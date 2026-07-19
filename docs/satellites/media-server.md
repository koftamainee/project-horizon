# Media Server (SRS)

## Overview

SRS (Simple Realtime Server) is the media server responsible for receiving RTMP streams from streamers and distributing them through the video pipeline. We use it as ingest server.

## Stack

- **Software:** SRS (Simple Realtime Server)
- **Ingestion protocol:** RTMP, SRT support later

## Responsibilities

- Accept incoming RTMP streams
- Validate RTMP connection tokens
- Forward streams to transcoding workers for processing
- Publish stream lifecycle events to streaming control plane

## Why SRS
There was 2 other options: MediaMTX and self written server. We will only transition to self written when we really need it, so I just compares MediaMTX and SRS.
SRS is older, written in C++ and more performant. Also, it supports cluster mode out-of-the-box and has a better hooks API.

## Stream Flow

1. Streamer publishes RTMP stream to SRS
2. SRS accepts the connection and begins receiving video data
3. SRS calls `on_publish` hook registered from streaming control plane
4. SRS forwards the stream to transcoding workers by request from them
5. SRS calls `on_unpublish` hook registered from streaming control plane

