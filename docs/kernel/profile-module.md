# Profile Module

## Overview

The Profile module manages user profiles and account settings.

## Stack

- **Language:** Go
- **Database:** PostgreSQL, `profile` schema

## Responsibilities

- Public profile management
- Account settings
- Public user info CRUD

## Database Schema

### `profile.profiles`

| Column         | Type        | Constraints             |
|----------------|-------------|-------------------------|
| `user_id`      | UUID        | PK, FK -> auth.users.id |
| `display_name` | TEXT        | NOT NULL                |
| `bio`          | TEXT        | -                       |
| `created_at`   | TIMESTAMPTZ | NOT NULL, DEFAULT now() |
| `updated_at`   | TIMESTAMPTZ | NOT NULL, DEFAULT now() |

### `profile.user_settings`

| Column       | Type        | Constraints             |
|--------------|-------------|-------------------------|
| `user_id`    | UUID        | PK, FK -> auth.users.id |
| `language`   | TEXT        | NOT NULL, DEFAULT 'en'  |
| `timezone`   | TEXT        | NOT NULL, DEFAULT 'UTC' |
| `save_vod`   | BOOLEAN     | NOT NULL, DEFAULT true  |
| `updated_at` | TIMESTAMPTZ | NOT NULL, DEFAULT now() |

## gRPC Server

TODO: Post-MVP — gRPC server for chat satellite

## API Endpoints

| Method | Path                            | Description                     |
|--------|---------------------------------|---------------------------------|
| GET    | `/users/{id}`                   | Get public profile by id        |
| GET    | `/users/by-username/{username}` | Get public profile by username  |
| PATCH  | `/users/me/profile`             | Update own profile              |
| GET    | `/users/me/settings`            | Get own account settings        |
| PATCH  | `/users/me/settings`            | Update own account settings     |
