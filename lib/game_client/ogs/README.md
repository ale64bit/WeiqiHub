# OGS (Online Go Server) Client

This directory contains the implementation of a GameClient for Online Go Server (online-go.com).

## Files

- `ogs_game_client.dart` - Main client implementation that handles authentication, game creation, and API communication
- `ogs_game.dart` - Game implementation that handles real-time game state through WebSocket connections (not yet implemented)

## Features

- Authentication with OGS using username/password

## API Endpoints

- Authentication: `POST /api/v0/login`

## TODO

- Implement gameplay
- Add error handling for network failures
- Add support for game analysis
- WebSocket connection  
- Game history retrieval
