# VOD Assembler

## Overview

The VOD assembler is a post-stream service that transforms live HLS artifacts into a proper VOD package. After a stream ends, it generates a VOD manifest, thumbnails, and preview clips from the segments already stored in MinIO.

## Stack

- **Language:** Go
- **Task queue:** NATS JetStream

## Responsibilities

- Consume stream ended events from NATS
- Generate VOD m3u8 manifest
- Generate thumbnail from stream
- Generate preview clip
- Write VOD artifacts back to MinIO
- Publish VOD ready event to NATS

## Why Go

The assembler does not do heavy transcoding, The main tasks are generating text manifests, extracting thumbnails, and light media operations. Go is sufficient, has good S3/MinIO SDK, and keeps the stack consistent with other Go services.

## NATS Events

### Consumed

TODO: consume stream.ended

### Published

TODO: produce vod.ready

## Configuration

TODO:

