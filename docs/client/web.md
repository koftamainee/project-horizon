# Web Client

## Overview

The web client provides browser-based access to Project Horizon.

## Stack

- **Framework:** React or Nuxt (TBD)
- **Language:** TypeScript

## Connections

| Service | Protocol | Purpose |
|---|---|---|
| Kernel | HTTP/gRPC | Auth, user profiles, stream metadata |
| Chat satellite | WebSocket (Phoenix Channels) | Real-time chat, online status |
| SRS media server | Stream playback | Live stream viewing |
| MinIO | HTTP (S3 API) | VOD playback |

## Browser Support

<!-- TODO: Document supported browsers, minimum versions -->
