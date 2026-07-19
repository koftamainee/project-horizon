# Message Queue (NATS JetStream)

## Overview

NATS with JetStream is the event backbone of the project. It provides async, persistent, at-least-once delivery for inter-service communication between Kernel, Streaming Control Plane, Transcoding Workers, and VOD Assembler.

## Used By

- **Streaming control plane** — publish stream lifecycle events
- **Kernel (stream module)** — subscribe to stream events
- **Kernel (vod module)** — subscribe to `stream.ended`, `vod.ready`; publish `vod.assemble`
- **Transcoding workers** — consume transcoding tasks, publish heartbeats
- **VOD assembler** — consume assembly tasks

## Why NATS + JetStream

- Lightweight and fast
- JetStream adds persistence and replay
- First-class Go support
- Built-in queue groups for load balancing
- Simple clustering for HA

## Subjects

### Stream Lifecycle

| Subject          | Publisher     | Consumer               |
|------------------|---------------|------------------------|
| `stream.started` | Control Plane | Kernel (stream module) |
| `stream.ended`   | Control Plane | Kernel (stream module) |

### Video Pipeline

| Subject           | Publisher     | Consumer           |
|-------------------|---------------|--------------------|
| `transcode.start` | Control Plane | Transcoding Worker |
| `transcode.stop`  | Control Plane | Transcoding Worker |

### Worker Health

| Subject               | Publisher          | Consumer      |
|-----------------------|--------------------|---------------|
| `transcode.heartbeat` | Transcoding Worker | Control Plane |

### VOD Pipeline

| Subject        | Publisher           | Consumer            |
|----------------|---------------------|---------------------|
| `vod.assemble` | Kernel (vod module) | VOD Assembler       |
| `vod.ready`    | VOD Assembler       | Kernel (vod module) |


## JetStream Streams

### `STREAM_EVENTS`

```
Subjects: stream.>
Storage: File
Retention: Limits
Max Age: 7d
Max Bytes: 1GB
Replicas: 1
```

### `TRANSCODE_TASKS`

```
Subjects: transcode.>
Storage: File
Retention: Limits
Max Age: 7d
Max Bytes: 1GB
Replicas: 1
```

### `VOD_EVENTS`

```
Subjects: vod.>
Storage: File
Retention: Limits
Max Age: 30d
Max Bytes: 1GB
Replicas: 1
```

## Consumers

### Stream Module — `stream-events-consumer`

```
Stream: STREAM_EVENTS
Subjects: [stream.started, stream.ended]
Deliver: All
Ack: Explicit
Max Deliver: 3
```

### Transcoding Workers — `transcode-tasks-consumer`

```
Stream: TRANSCODE_TASKS
Subjects: [transcode.start, transcode.stop]
Deliver: All
Ack: Explicit
Max Deliver: 3
Queue Group: workers
```

### VOD Assembler — `vod-events-consumer`

```
Stream: VOD_EVENTS
Subjects: [vod.assemble]
Deliver: All
Ack: Explicit
Max Deliver: 3
Queue Group: vod-assemblers
```

### VOD Module — `vod-ready-consumer`

```
Stream: VOD_EVENTS
Subjects: [vod.ready]
Deliver: All
Ack: Explicit
Max Deliver: 3
```

### Control Plane — `heartbeat-consumer`

```
Stream: TRANSCODE_TASKS
Subjects: [transcode.heartbeat]
Deliver: All
Ack: None
```

## Queue Groups

| Queue Group      | Purpose                                       | Members             |
|------------------|-----------------------------------------------|---------------------|
| `workers`        | Load balance transcoding tasks across workers | Transcoding Workers |
| `vod-assemblers` | Load balance VOD assembly across instances    | VOD Assemblers      |

## Acknowledgment

- **`transcode.start`** — Worker acks after starting FFmpeg process
- **`transcode.stop`** — Worker acks after killing FFmpeg process
- **`transcode.heartbeat`** — Fire and forget, no ack needed
- **`vod.assemble`** — Assembler acks after starting assembly
- **`vod.ready`** — Kernel acks after updating DB
- **`stream.started`** — Kernel acks after updating DB
- **`stream.ended`** — Kernel acks after updating DB

## Error Handling

- If worker crashes during transcoding, `transcode.start` is redelivered (max 3 times)
- If max deliver exceeded, event goes to dead letter queue
- Control plane monitors heartbeats; if absent for 30s, reassigns task
