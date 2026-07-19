# Chat Satellite

## Overview

The Chat satellite is a dedicated microservice for real-time chat.

## Stack

- **Language:** Elixir
- **Framework:** Phoenix 
- **Database:** ScyllaDB
- **gRPC client:** Kernel

## Responsibilities

- WebSocket connection management
- Real-time chat messaging
- Chat message persistence in ScyllaDB

## Why Elixir

- BEAM VM is great for huge amount of WebSocket connections due to actor model
- Phoenix Channels are purposefully built for tasks like this
- Isolated from the Go Kernel to prevent WebSocket load from affecting CRUD operations

## WebSocket Protocol

**Connection:** `wss://<host>/ws?token=<jwt>`

### Events

| Direction        | Event           |
|------------------|-----------------|
| Client -> Server | Join channel    |
| Client -> Server | Send message    |
| Server -> Client | Message history |
| Server -> Client | New message     |

## gRPC Client

TODO: Post-MVP — user data enrichment (username, avatar) via Kernel
