# Stream Module

## Overview

The Stream module manages stream metadata and lifecycle state.

## Stack

- **Language:** Go
- **Database:** PostgreSQL, `stream` schema
- **NATS:** subscribes to `stream.started`, `stream.ended`

## Responsibilities

- Stream metadata CRUD
- Stream status tracking
- Stream discovery and listing
- Stream lifecycle coordination with streaming control plane

## Stream Lifecycle

1. Streamer creates/updates stream metadata via API
2. Stream status is set to `idle`
3. Streamer starts OBS → RTMP publish → SRS accepts stream
4. Streaming control plane publishes `stream.started` to NATS
5. Kernel receives event, updates status to `live`
6. Streamer stops OBS → `stream.ended` published
7. Kernel receives event, updates status to `ended`

## Database Schema

### `stream.streams`

| Column        | Type        | Constraints                   |
|---------------|-------------|-------------------------------|
| `id`          | UUID        | PK, DEFAULT gen_random_uuid() |
| `user_id`     | UUID        | FK -> auth.users.id, NOT NULL |
| `title`       | TEXT        | -                             |
| `category_id` | UUID        | FK -> stream.categories.id    |
| `status`      | TEXT        | NOT NULL, DEFAULT 'idle'      |
| `started_at`  | TIMESTAMPTZ | -                             |
| `ended_at`    | TIMESTAMPTZ | -                             |
| `created_at`  | TIMESTAMPTZ | NOT NULL, DEFAULT now()       |
| `updated_at`  | TIMESTAMPTZ | NOT NULL, DEFAULT now()       |
| `deleted_at`  | TIMESTAMPTZ | -                             |

NOTE: `status` is one of `idle`, `live`, `ended`. Idle status exists to allow streamer to edit metadata, and just launch stream in OBS. By default, there will be created one idle stream for each user. When streamer launches stream from OBS, state will be changed to live, and after end of the stream new record will be created, with same metadata as latest live stream, but with idle status

### `stream.categories`

| Column | Type | Constraints      |
|--------|------|------------------|
| `id`   | UUID | PK               |
| `name` | TEXT | UNIQUE, NOT NULL |

## NATS Events

### Subscribed

| Event            | Source                  | Action                                                        |
|------------------|-------------------------|---------------------------------------------------------------|
| `stream.started` | Streaming control plane | Set status to `live`, set `started_at`                        |
| `stream.ended`   | Streaming control plane | Set status to `ended`, set `ended_at`, create new idle stream |

## API Endpoints

| Method | Path                  | Description                                 |
|--------|-----------------------|---------------------------------------------|
| GET    | `/streams`            | List streams (with filters in query params) |
| GET    | `/streams/{id}`       | Get stream by id                            |
| PATCH  | `/streams/{id}`       | Update stream metadata                      |
| GET    | `/categories`         | List available categories                   |

