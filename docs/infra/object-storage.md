# Object Storage (MinIO)

## Overview

MinIO is an S3-compatible object storage used as the stream fragments / playlists and VOD repository.

## Used By

- **Transcoding workers** — write transcoded video segments
- **VOD assembler** — read segments, write assembled VOD files

## What It Stores

- Transcoded video segments (from transcoding workers)
- Assembled VOD files (from VOD assembler)
- Stream recordings and archives

## Bucket Structure

TODO:

## Configuration

TODO: