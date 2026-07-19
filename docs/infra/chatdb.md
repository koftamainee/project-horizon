# ScyllaDB

## Overview

ScyllaDB is the database for the Chat satellite. It stores chat message history independently from the primary PostgreSQL database.

## Used By

- **Chat satellite** — read/write for chat messages

## Why ScyllaDB

- High write throughput for chat messages
- Low latency reads for message history
- Horizontally scalable
- Cassandra-compatible, but doesn't require voodoo magic with JVM

## What It Stores

### `chat.messages`

All chat messages for a stream. Messages persist after the stream ends.

| Column       | Type      | Description                 |
|--------------|-----------|-----------------------------|
| `channel_id` | UUID      | stream_id — partition key   |
| `message_id` | TIMEUUID  | unique message ID, sort key |
| `user_id`    | UUID      | author of the message       |
| `content`    | TEXT      | message text                |
| `created_at` | TIMESTAMP | when message was created    |

**Primary Key:** `(channel_id, message_id)`
**Clustering Order:** `message_id DESC` (newest first)