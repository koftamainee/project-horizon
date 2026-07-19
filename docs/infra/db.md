# PostgreSQL

## Overview

PostgreSQL is the primary ACID-compliant relational database for. It stores all core business data managed by the Kernel.

## Used By

- **Kernel** — read/write for all business logic

## Why PostgreSQL
It is de-facto standard in relational ACID database sphere. 

## Schemas

| Schema    | Module         | Description                     |
|-----------|----------------|---------------------------------|
| `auth`    | Auth module    | Users, refresh tokens, sessions |
| `profile` | Profile module | User profiles, settings         |
| `stream`  | Stream module  | Streams, categories             |
| `follow`  | Follow module  | Follow relationships, counts    |
| `vod`     | VOD module     | VOD records, assembly status    |

## Configuration

TODO:
