interface PlayerInfo {
    name: string;
    ready: boolean;
    results?: any;
    isCreator: boolean;
    joinedAt: number;
}

export class TsumegoRoom implements DurableObject {
    state: DurableObjectState;
    players = new Map<WebSocket, PlayerInfo>();
    roomSettings: any = null;
    battleStarted = false;
    startTime: number | null = null;
    battleFinished = false;

    constructor(state: DurableObjectState) {
        this.state = state;
        // Load initial state from storage
        this.state.blockConcurrencyWhile(async () => {
            this.roomSettings = await this.state.storage.get("roomSettings") || null;
            this.battleStarted = await this.state.storage.get("battleStarted") || false;
            this.startTime = await this.state.storage.get("startTime") || null;
            this.battleFinished = await this.state.storage.get("battleFinished") || false;

            if (this.battleStarted && !this.battleFinished && this.startTime && this.roomSettings) {
                const elapsed = Date.now() - this.startTime;
                const limit = this.roomSettings.timeLimitSeconds * 1000;
                if (elapsed >= limit) {
                    await this.finishBattle();
                } else {
                    await this.state.storage.setAlarm(this.startTime + limit + 5000);
                }
            }
        });
    }

    async alarm() {
        if (this.battleStarted && !this.battleFinished) {
            await this.finishBattle();
        }
    }

    async fetch(request: Request) {
        const url = new URL(request.url);

        if (request.method === "OPTIONS") {
            return new Response(null, {
                headers: {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
                    "Access-Control-Allow-Headers": "Content-Type",
                }
            });
        }

        if (request.headers.get("Upgrade") !== "websocket") {
            return new Response("Expected Upgrade: websocket", {
                status: 426,
                headers: { "Access-Control-Allow-Origin": "*" }
            });
        }

        const playerName = url.searchParams.get("name") || "Anonymous";
        const [client, server] = new WebSocketPair();

        await this.handleSession(server, playerName);

        return new Response(null, { status: 101, webSocket: client });
    }

    async handleSession(ws: WebSocket, name: string) {
        // @ts-ignore
        ws.accept();

        // If a player with the same name already exists, close the old connection
        for (const [oldWs, info] of this.players.entries()) {
            if (info.name === name) {
                console.log(`Closing old connection for player: ${name}`);
                oldWs.close(1000, "Reconnected");
                this.players.delete(oldWs);
            }
        }

        // Assign creator if no one is creator
        const hasCreator = Array.from(this.players.values()).some(p => p.isCreator);
        const player: PlayerInfo = {
            name,
            ready: false,
            isCreator: !hasCreator,
            joinedAt: Date.now()
        };
        this.players.set(ws, player);

        this.broadcastState();

        ws.addEventListener("message", async (msg) => {
            try {
                const data = JSON.parse(msg.data as string);
                this.handleMessage(ws, data);
            } catch (e) {
                console.error("Failed to parse message", e);
                ws.send(JSON.stringify({ type: "ERROR", message: "Invalid message format" }));
            }
        });

        ws.addEventListener("close", () => {
            this.removePlayer(ws);
        });

        ws.addEventListener("error", (e) => {
            console.error("WebSocket error", e);
            this.removePlayer(ws);
        });
    }

    async removePlayer(ws: WebSocket) {
        const player = this.players.get(ws);
        if (!player) return;

        this.players.delete(ws);

        if (this.players.size > 0 && player.isCreator) {
            // Transfer creator status to the player who joined earliest among remaining
            const remaining = Array.from(this.players.entries());
            remaining.sort((a, b) => a[1].joinedAt - b[1].joinedAt);
            if (remaining.length > 0) {
                remaining[0][1].isCreator = true;
            }
        }

        // Check if battle should finish now that someone left
        if (this.battleStarted && !this.battleFinished && this.allFinished()) {
            await this.finishBattle();
        }

        if (this.players.size === 0) {
            // Clean up room data if everyone left
            await this.state.storage.deleteAll();
            this.roomSettings = null;
            this.battleStarted = false;
            this.startTime = null;
            this.battleFinished = false;
            await this.state.storage.deleteAlarm();
        }

        this.broadcastState();
    }

    async handleMessage(ws: WebSocket, data: any) {
        const player = this.players.get(ws);
        if (!player) return;

        switch (data.type) {
            case "P2P_PING":
                ws.send(JSON.stringify({ type: "P2P_PONG", timestamp: Date.now() }));
                break;
            case "REQUEST_STATE":
                this.broadcastState();
                break;
            case "SETUP":
                if (player.isCreator) {
                    this.roomSettings = data.settings;
                    await this.state.storage.put("roomSettings", this.roomSettings);
                    this.broadcastState();
                }
                break;
            case "READY":
                player.ready = data.ready;
                this.broadcastState();
                break;
            case "START":
                if (player.isCreator && this.allReady() && this.roomSettings && !this.battleStarted) {
                    this.battleStarted = true;
                    this.battleFinished = false;
                    this.startTime = Date.now();
                    await this.state.storage.put("battleStarted", true);
                    await this.state.storage.put("startTime", this.startTime);
                    await this.state.storage.put("battleFinished", false);

                    await this.state.storage.setAlarm(this.startTime + (this.roomSettings.timeLimitSeconds * 1000) + 5000);

                    this.broadcast({
                        type: "BATTLE_STARTED",
                        startTime: this.startTime,
                        serverTime: Date.now()
                    });
                }
                break;
            case "SUBMIT_RESULTS":
                player.results = data.results;
                this.broadcastState();
                if (this.allFinished() && this.battleStarted && !this.battleFinished) {
                    await this.finishBattle();
                }
                break;
            case "CHAT":
                this.broadcast({
                    type: "CHAT_MESSAGE",
                    sender: player.name,
                    text: data.text,
                    timestamp: Date.now()
                });
                break;
            case "KICK":
                if (player.isCreator) {
                    const targetName = data.playerName;
                    for (const [targetWs, targetInfo] of this.players.entries()) {
                        if (targetInfo.name === targetName && !targetInfo.isCreator) {
                            targetWs.send(JSON.stringify({ type: "KICKED" }));
                            targetWs.close(1000, "Kicked by creator");
                            this.removePlayer(targetWs);
                            break;
                        }
                    }
                }
                break;
            case "RESTART":
                if (player.isCreator && this.battleFinished) {
                    this.battleStarted = false;
                    this.battleFinished = false;
                    this.startTime = null;
                    for (const p of this.players.values()) {
                        p.ready = false;
                        p.results = undefined;
                    }
                    await this.state.storage.put("battleStarted", false);
                    await this.state.storage.put("startTime", null);
                    await this.state.storage.put("battleFinished", false);
                    await this.state.storage.deleteAlarm();
                    this.broadcastState();
                    this.broadcast({ type: "BATTLE_RESTARTED" });
                }
                break;
        }
    }

    async finishBattle() {
        this.battleFinished = true;
        await this.state.storage.put("battleFinished", true);
        await this.state.storage.deleteAlarm();
        this.broadcast({ type: "BATTLE_FINISHED" });
    }

    allReady() {
        if (this.players.size < 2) return false;
        for (const p of this.players.values()) {
            if (!p.ready) return false;
        }
        return true;
    }

    allFinished() {
        if (this.players.size === 0) return false;
        for (const p of this.players.values()) {
            if (!p.results) return false;
        }
        return true;
    }

    broadcastState() {
        const state = {
            type: "STATE_UPDATE",
            players: Array.from(this.players.values()).map(p => ({
                name: p.name,
                ready: p.ready,
                isCreator: p.isCreator,
                hasResults: !!p.results,
                results: p.results
            })),
            roomSettings: this.roomSettings,
            battleStarted: this.battleStarted,
            battleFinished: this.battleFinished,
            startTime: this.startTime,
            serverTime: Date.now(),
        };
        this.broadcast(state);
    }

    broadcast(message: any) {
        const data = JSON.stringify(message);
        for (const ws of this.players.keys()) {
            try {
                ws.send(data);
            } catch (e) {
                console.error("Failed to send message to player, removing connection", e);
                this.removePlayer(ws);
            }
        }
    }
}
