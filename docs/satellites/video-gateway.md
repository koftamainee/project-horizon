# Video Gateway (nginx)

## Overview

The Video Gateway is an nginx instance configured as a caching reverse proxy for HLS video delivery. It sits between MinIO and end viewers, handling high-concurrency video streaming without exposing S3 directly to clients.

## Stack

- **Software:** nginx
- **Upstream:** MinIO

## Responsibilities

- Serve HLS segments (.ts) and playlists (.m3u8) from MinIO
- Cache hot content in RAM for fast delivery
- Handle thousands of concurrent viewers per stream
- Serve live streams and VOD content
- Support future CDN integration

## Why nginx

- Battle-tested for static file serving and HLS delivery
- Excellent caching with `proxy_cache` and in-memory caching
- Low resource usage, high concurrency
- Simple configuration for HLS-specific caching rules
- Easy to replace with CDN (Cloudflare, CloudFront) later


## Configuration

TODO: