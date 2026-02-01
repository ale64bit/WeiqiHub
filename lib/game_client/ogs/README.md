# OGS (Online Go Server)

Client implementation for [online-go.com](https://online-go.com).

## Overview

WeiqiHub interacts with OGS via the `GameClient` and `Game` interfaces.  OGS implementations are:

- `OGSGameClient`
- `OGSGame`

OGS exposes a REST API and a WebSocket interface.  The OGS module uses HttpClient and OGSWebSocketManager to interact with these APIs.

## Testing

### Unit Tests

New code should have unit tests covering the happy path and key error scenarios.
Unit tests live in `test/` and run with:

```bash
flutter test --exclude-tags=integration
```

### Integration Tests

Integration tests run against the real OGS beta server. You'll need a test account
on [beta.online-go.com](https://beta.online-go.com).

```bash
OGS_TEST_USERNAME=your_username OGS_TEST_PASSWORD=your_password flutter test --tags=integration
```

### Manual Testing

For interactive testing during development:

1. Create a test account on [beta.online-go.com](https://beta.online-go.com)
2. Build and run the app
3. On the "Play" tab, select OGS
3. Log in with your test account
4. Use a second browser/device logged into beta.online-go.com to act as an opponent

> **Note:** Use the beta server for development to avoid disrupting real games or players.  This is done automatically for non-release builds.

## External References

When adding new features for WeiqiHub, you'll likely want to use the official
web client as reference.

- [OGS source](https://github.com/online-go/online-go.com) — No official API docs; read their code
- [Goban library](https://github.com/online-go/goban) — OGS's game logic reference
