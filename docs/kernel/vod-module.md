# VOD Module

## Overview

The VOD module manages Video-On-Demand records. It decides whether to create a VOD from a finished stream based on user preferences, and processes completion events from the VOD assembler.

## Stack

- **Language:** Go
- **Database:** PostgreSQL, `vod` schema
- **NATS:** subscribes to `stream.ended`, `vod.ready`; publishes `vod.assemble`

## Responsibilities

- Decide whether to trigger VOD assembly based on user `save_vod` preference
- Track VOD lifecycle (assembling → ready / failed)
- Store VOD metadata (manifest path, thumbnail, duration)
- Provide VOD listing and playback info via API

## VOD Lifecycle

1. Stream ends → Kernel receives `stream.ended` from streaming control plane
2. Stream module notifies VOD module
3. VOD module checks `profile.user_settings.save_vod` for stream owner
4. If enabled → VOD module creates a record with status `assembling`
5. VOD module publishes `vod.assemble` to NATS with stream_id and manifest path
6. VOD assembler consumes event, generates VOD manifest + thumbnail
7. VOD assembler publishes `vod.ready`
8. VOD module receives event, updates status to `ready`, stores metadata

## Database Schema

### `vod.vods`

| Column           | Type        | Constraints                            |
|------------------|-------------|----------------------------------------|
| `id`             | UUID        | PK, DEFAULT gen_random_uuid()          |
| `stream_id`      | UUID        | FK -> stream.streams, NOT NULL, UNIQUE |
| `user_id`        | UUID        | FK -> auth.users.id, NOT NULL          |
| `status`         | TEXT        | NOT NULL, DEFAULT 'assembling'         |
| `manifest_path`  | TEXT        | -                                      |
| `thumbnail_path` | TEXT        | -                                      |
| `duration`       | INT         | -                                      |
| `created_at`     | TIMESTAMPTZ | NOT NULL, DEFAULT now()                |
| `updated_at`     | TIMESTAMPTZ | NOT NULL, DEFAULT now()                |
| `deleted_at`     | TIMESTAMPTZ | -                                      |

NOTE: `status` is one of `assembling`, `ready`, `failed`. `manifest_path` and `thumbnail_path` are MinIO object keys.

## NATS Events

### Subscribed

| Event          | Source                  | Action                                                       |
|----------------|-------------------------|--------------------------------------------------------------|
| `stream.ended` | Kernel (stream module)  | Check `save_vod` setting, create record, emit `vod.assemble` |
| `vod.ready`    | VOD assembler           | Update record status to `ready`, store metadata              |

### Published

| Event          | Consumer      |
|----------------|---------------|
| `vod.assemble` | VOD assembler |

## API Endpoints

| Method | Path               | Description          |
|--------|--------------------|----------------------|
| GET    | `/users/{id}/vods` | List VODs for a user |
| GET    | `/vods/{id}`       | Get VOD by id        |
| DELETE | `/vods/{id}`       | Delete a VOD         |

