# Object Storage (MinIO)

## Overview

MinIO is an S3-compatible object storage used as the stream fragments / playlists and VOD repository.

## Used By

- **Transcoding workers** — write HLS segments during live
- **VOD assembler** — read segments, write VOD manifest + thumbnail + preview
- **Video gateway (nginx)** — read HLS segments and playlists to serve viewers

## What It Stores

- Live HLS segments (.ts)
- Live HLS playlist (.m3u8, sliding window)
- VOD HLS playlist (.m3u8, full + EXT-X-ENDLIST)
- VOD thumbnails
- VOD preview clips

## Bucket Structure

```
streams/
  {stream_id}/
    segment_000.ts          # HLS segments (written by transcoding worker)
    segment_001.ts
    ...
    live.m3u8               # Live playlist (sliding window, updated by worker)
    vod.m3u8                # VOD playlist (all segments + EXT-X-ENDLIST, written by assembler)
    thumbnail.jpg           # Poster image (written by assembler)
    preview.mp4             # Short preview clip (written by assembler)
```

## Object Lifecycle

| Object          | Writer             | When              | Mutable              |
|-----------------|--------------------|-------------------|----------------------|
| `segment_*.ts`  | Transcoding worker | During live       | No (immutable)       |
| `live.m3u8`     | Transcoding worker | During live       | Yes (sliding window) |
| `vod.m3u8`      | VOD assembler      | After stream ends | No (immutable)       |
| `thumbnail.jpg` | VOD assembler      | After stream ends | No                   |
| `preview.mp4`   | VOD assembler      | After stream ends | No                   |

## Access Patterns

| Consumer      | Reads                        | Path                   |
|---------------|------------------------------|------------------------|
| Live viewer   | `live.m3u8` + `segment_*.ts` | `streams/{stream_id}/` |
| VOD viewer    | `vod.m3u8` + `segment_*.ts`  | `streams/{stream_id}/` |
| VOD assembler | `segment_*.ts`               | `streams/{stream_id}/` |

