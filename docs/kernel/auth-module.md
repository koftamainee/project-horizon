# Auth Module

## Overview

The Auth module handles user authentication and authorization within the Kernel. It manages registration, login, token lifecycle, and session management.

## Stack

- **Language:** Go
- **Database:** PostgreSQL, `auth` schema
- **Token format:** JWT access + refresh

## Responsibilities

- User registration
- Login and logout
- Password hashing and verification
- JWT token generation and validation

## Database Schema

### `auth.users`

| Column          | Type        | Constraints                   |
|-----------------|-------------|-------------------------------|
| `id`            | UUID        | PK, DEFAULT get_random_uuid() |
| `email`         | TEXT        | NOT NULL                      |
| `username`      | TEXT        | NOT NULL                      |
| `password_hash` | TEXT        | NOT NULL                      |
| `created_at`    | TIMESTAMPTZ | NOT NULL, DEFAULT now()       |
| `updated_at`    | TIMESTAMPTZ | NOT NULL, DEFAULT now()       |
| `banned_at`     | TIMESTAMPTZ | -                             |
| `ban_reason`    | TEXT        | -                             |
| `deleted_at`    | TIMESTAMPTZ | -                             |

NOTE: email and username should be unique, where deleted_at is NULL, additional unique indexes created.


### `auth.refresh_tokens`

| Column       | Type        | Constraints                   |
|--------------|-------------|-------------------------------|
| `id`         | UUID        | PK, DEFAULT gen_random_uuid() |
| `user_id`    | UUID        | FK -> auth.users.id, NOT NULL |
| `token_hash` | TEXT        | UNIQUE, NOT NULL              |
| `user_agent` | TEXT        | -                             |
| `expires_at` | TIMESTAMPTZ | NOT NULL                      |
| `revoked_at` | TIMESTAMPTZ | -                             |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT now()       |

NOTE: additional index only on active users (revoked_at is NULL)

## API Endpoints

All endpoints accept and return `Content-Type: application/json`.

Token storage:
- **Access token** — `Authorization: Bearer <token>` header
- **Refresh token** — `HttpOnly`, `Secure`, `SameSite=Strict` cookie

| Method | Path                    | Description                                    |
|--------|-------------------------|------------------------------------------------|
| POST   | `/auth/register`        | Create a new user account                      |
| POST   | `/auth/login`           | Authenticate and receive tokens                |
| POST   | `/auth/refresh`         | Exchange refresh token for new access token    |
| POST   | `/auth/logout`          | Invalidate refresh token and revoke session    |
| POST   | `/auth/logout-all`      | Invalidate all tokens and sessions             |
| GET    | `/auth/sessions`        | Get all active sessions                        |
| DELETE | `/auth/sessions/{id}`   | Revoke session by id                           |
| POST   | `/auth/password/change` | Change password                                |

## Configuration

TODO: