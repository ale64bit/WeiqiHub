export interface Env {
	ROOMS: DurableObjectNamespace;
}

const CORS_HEADERS = {
	"Access-Control-Allow-Origin": "*",
	"Access-Control-Allow-Methods": "GET, POST, OPTIONS",
	"Access-Control-Allow-Headers": "Content-Type",
};

export default {
	async fetch(request: Request, env: Env): Promise<Response> {
		const url = new URL(request.url);

		if (request.method === "OPTIONS") {
			return new Response(null, { headers: CORS_HEADERS });
		}

		if ((url.pathname === "/create" || url.pathname === "/create/") && request.method === "POST") {
			const roomId = Math.random().toString(36).substring(2, 8).toUpperCase();
			return new Response(JSON.stringify({ roomId }), {
				headers: {
					"Content-Type": "application/json",
					...CORS_HEADERS
				},
			});
		}

		const roomMatch = url.pathname.match(/^\/room\/([A-Z0-9]{6})\/?$/);
		if (roomMatch) {
			try {
				const roomId = roomMatch[1];
				const doId = env.ROOMS.idFromName(roomId);
				const roomObject = env.ROOMS.get(doId);
				return await roomObject.fetch(request);
			} catch (e) {
				return new Response(JSON.stringify({ error: e instanceof Error ? e.message : String(e) }), {
					status: 500,
					headers: { "Content-Type": "application/json", ...CORS_HEADERS }
				});
			}
		}

		return new Response("Not Found", { status: 404, headers: CORS_HEADERS });
	},
};

export { TsumegoRoom } from "./room";
