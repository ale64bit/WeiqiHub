# P2P Tsumego Battle Server Creation Guide

This guide explains how to set up and deploy the Cloudflare Worker that serves as the backend for P2P Tsumego Battles.

## Prerequisites

1.  A [Cloudflare account](https://dash.cloudflare.com/sign-up).
2.  [Node.js and npm](https://nodejs.org/) installed on your machine.
3.  [Wrangler](https://developers.cloudflare.com/workers/wrangler/install-and-update/) installed (`npm install -g wrangler`).

## Deployment Steps

1.  **Navigate to the server directory**:
    ```bash
    cd lib/p2p_battle/server
    ```

2.  **Install dependencies**:
    ```bash
    npm install
    ```

    *Note: If you see a warning about Wrangler being out-of-date, running `npm install` again should update it to the version specified in `package.json` (v4).*

3.  **Login to Cloudflare**:
    ```bash
    npx wrangler login
    ```

4.  **Deploy the Worker**:
    ```bash
    npm run deploy
    ```

    *Note: Ensure you are running this from the `lib/p2p_battle/server` directory. If it still says "Missing entry-point", try `npx wrangler deploy src/index.ts`.*

    After deployment, Wrangler will provide you with a URL (e.g., `https://wqhub-p2p.your-subdomain.workers.dev`).

## Hardcoding the URL via GitHub Secrets (CI/CD)

Since we are using GitHub Actions for desktops,

1.  **Add a Secret to your GitHub Repository**:
    - Go to your repository settings on GitHub.
    - Select **Secrets and variables > Actions**.
    - Click **New repository secret**.
    - Name: `P2P_SERVER_URL`
    - Value: `https://your-worker.workers.dev`

2.  **Update your Workflow**:
    - Modify your build workflow (e.g., `.github/workflows/build_linux.yaml`) to pass this secret during the build step.
    - Add `--dart-define=P2P_SERVER_URL=${{ secrets.P2P_SERVER_URL }}` to your `flutter build` command.

    Example for Linux:
    ```yaml
    - name: Build
        env:
          NO_OPUS_OGG_LIBS: 1
        run: flutter build linux
          --dart-define=P2P_SERVER_URL=${{ secrets.P2P_SERVER_URL }} \
          --obfuscate \
          --split-debug-info=out/linux \
    ```

3.  **Local Development**:
    - You can also pass it locally when running or building:
      ```bash
      flutter run -d linux --dart-define=P2P_SERVER_URL=https://wqhub-p2p.soumyak4.workers.dev/
      ```
      ```bash
      flutter build apk --target-platform android-arm64 --dart-define=P2P_SERVER_URL=https://wqhub-p2p.soumyak4.workers.dev/

## Redeploying or Resetting the Server

If you have deleted the Worker from your Cloudflare dashboard, or if you want to perform a fresh installation:

1.  **Re-run the Deployment**:
    Simply navigate to `lib/p2p_battle/server` and run `npm run deploy` again.
    Wrangler will:
    - Re-create the Worker.
    - Re-create the Durable Object namespace (if it doesn't exist).
    - Bind the namespace to the Worker.

2.  **Verify the URL**:
    Check the output of the deploy command to see if your Worker URL has changed. If it has, make sure to update your GitHub Secrets or app settings accordingly.

3.  **Troubleshooting "Namespace Not Found"**:
    If you see errors related to the Durable Object namespace after redeploying, ensure that your `wrangler.toml` has the correct `[[durable_objects.bindings]]` section. Running `npx wrangler deploy` normally handles this automatically.

## How it works

The backend is a Cloudflare Worker that uses **Durable Objects** to maintain state for each battle room.

- **Rooms**: Each room is a unique Durable Object instance identified by a short ID.
- **WebSockets**: Real-time communication between players is handled via WebSockets connected to the room's Durable Object.
- **State Management**:
    - The room tracks joined players and their "Ready" status.
    - **Time Synchronization**: The server provides a synchronized start time and current server time to all clients, ensuring everyone has the same time limit regardless of their local clock settings.
    - The creator (the player who created the room) sets the task list and time limit.
    - Once everyone is ready, the creator starts the battle.
    - During the battle, players work locally on their devices.
    - Upon finishing or timeout, players submit their results to the room.
    - The room aggregates results and broadcasts the final leaderboard.
- **Cleanup**: Rooms and their data are automatically cleaned up after the battle is finished or after a period of inactivity.

## Room Management

Durable Objects are automatically managed by Cloudflare. They spin up when a player connects and spin down when idle.

- **Monitoring**: You can view usage and metrics in the Cloudflare Dashboard under **Workers & Pages > [Your Worker] > Monitor**.
- **Namespace Info**: Use `npx wrangler durable-objects namespaces list` to see details about your Durable Object namespaces.
- **Persistence**: Currently, room data (settings, ready status) is stored in the Durable Object's memory. If the object is evicted due to inactivity, the room is effectively closed.

## Features

- **Real-time Synchronization**: Uses WebSockets to sync player readiness and battle starts.
- **Persistent State**: Room settings and battle status are persisted using Durable Object storage, reducing errors during worker restarts.
- **Chat**: Players can communicate in the lobby via a built-in chat system.
- **Player Management**: Creators can kick players from the room.
- **Rematch**: After a battle, the creator can initiate a rematch, bringing everyone back to the lobby with the same settings.
- **Fault Tolerance**: Improved error handling and connection management to ensure a smooth experience on Cloudflare.

## Customization

You can modify `lib/p2p_battle/server/src/index.ts` and `room.ts` to change the behavior of the rooms, add new features, or implement different matchmaking logic.
