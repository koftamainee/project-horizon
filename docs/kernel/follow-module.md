# Follow Module

## Overview

The Follow module manages follow/unfollow relationships between users. 

## Stack

- **Language:** Go
- **Database:** PostgreSQL, `follow` schema

## Responsibilities

- Follow and unfollow users
- Follower and following counts
- Check follow status between users
- List followers and following for a user

## Database Schema

### `follow.follows`

| Column         | Type         | Constraints                   |
|----------------|--------------|-------------------------------|
| `id`           | UUID         | PK, DEFAULT gen_random_uuid() |
| `follower_id`  | UUID         | FK -> auth.users.id, NOT NULL |
| `following_id` | UUID         | FK -> auth.users.id, NOT NULL |
| `created_at`   | TIMESTAMPTZ  | NOT NULL, DEFAULT now()       |

NOTE: Unique index on (`follower_id`, `following_id`). Additional index on `following_id` for reverse lookups.

### `follow.follower_counts`

| Column            | Type     | Constraints             |
|-------------------|----------|-------------------------|
| `user_id`         | UUID     | PK, FK -> auth.users.id |
| `follower_count`  | BIGINT   | NOT NULL, DEFAULT 0     |
| `following_count` | BIGINT   | NOT NULL, DEFAULT 0     |

NOTE: Denormalized counts for fast reads. Updated on follow/unfollow.

## API Endpoints

| Method | Path                        | Description                     |
|--------|-----------------------------|---------------------------------|
| POST   | `/users/{id}/follow`        | Follow a user                   |
| DELETE | `/users/{id}/follow`        | Unfollow a user                 |
| GET    | `/users/{id}/followers`     | List followers of a user        |
| GET    | `/users/{id}/following`     | List users a user follows       |
| GET    | `/users/{id}/follow-status` | Check if following a user       |

