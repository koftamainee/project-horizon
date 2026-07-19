# Transcoding Worker

## Overview

Transcoding workers process video streams. They consume transcoding tasks, pull video from SRS, transcode it, and write the output to MinIO.

## Stack

- **Language:** C++
- **Task queue:** NATS JetStream

## Responsibilities

- Consume transcoding tasks from NATS, can process up to n tasks in parallel
- Pull video segments from SRS
- Sends heartbeats to NATS
- Transcode video to required formats and qualities
- Write transcoded segments to MinIO

## Why C++
Native FFmpeg and codecs libraries. That's it.

## NATS Events

### Consumed

TODO: consume stream urls from stream control plane

### Published

TODO: publish heartbeats

## Configuration

TODO:
