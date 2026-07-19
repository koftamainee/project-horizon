# Flutter Client (Mobile)

## Overview

The Flutter mobile client is the primary interface for viewers and streamers on mobile devices.

## Stack

- **Framework:** Flutter
- **Language:** Dart

## Connections

| Service | Protocol | Purpose |
|---|---|---|
| Kernel | HTTP/gRPC | Auth, user profiles, stream metadata |
| Chat satellite | WebSocket (Phoenix Channels) | Real-time chat, online status |
| SRS media server | Stream playback | Live stream viewing |
| MinIO | HTTP (S3 API) | VOD playback |

## Key Features

<!-- TODO: Document main screens, navigation, features -->

## Authentication

<!-- TODO: Document auth flow, token storage on mobile -->
