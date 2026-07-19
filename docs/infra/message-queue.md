# Message Queue (NATS JetStream)

## Overview

NATS with JetStream is the event backbone of the project. It provides async, persistent, at-least-once delivery for inter-service communication.

## Used By

- **Streaming control plane** — publish stream lifecycle events
- **Kernel** — subscribe to stream events
- **Transcoding workers** — consume transcoding tasks
- **VOD assembler** — consume assembly tasks

## Why NATS + JetStream

- Lightweight and fast
- JetStream adds persistence and replay
- First-class go support

TODO: describe all protocols and topics

## Configuration

TODO:

