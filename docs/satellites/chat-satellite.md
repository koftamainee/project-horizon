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
- Online status tracking with heartbeat
- Chat message persistence in ScyllaDB
- User data enrichment via gRPC calls to Kernel

## Why Elixir

- BEAM VM is great for huge amount of WebSocket connections due to actor model
- Phoenix Channels are purposefully built for tasks like this
- Isolated from the Go Kernel to prevent WebSocket load from affecting CRUD operations

## gRPC Client

TODO: 

## API

TODO: WS docs

## Configuration

TODO: