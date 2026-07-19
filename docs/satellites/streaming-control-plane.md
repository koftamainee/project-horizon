# Streaming Control Plane

## Overview

The Streaming control plane is a video pipeline component written in Go. It manages the flow of video data between SRS and the transcoding workers.

## Stack

- **Language:** Go

## Responsibilities

- Manage the video pipeline between SRS and transcoding workers
- Track current tasks and heartbeats from workers, if they are absent, resend task to new worker
- Publish stream lifecycle events to NATS

## Why Go
Service is I/O bound, don't need any specific runtime. Go is small, fast supports http (for hooks) out-of-the-box and has great NATS client.

## NATS Events

### Consumed

TODO: consumes heartbeats from workers

### Published

TODO: produce stream URL for workers

## Configuration

TODO:
