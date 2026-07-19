CREATE TABLE vod.vods (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    stream_id UUID UNIQUE NOT NULL REFERENCES stream.streams(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    status TEXT NOT NULL DEFAULT 'assembling',
    manifest_path TEXT,
    thumbnail_path TEXT,
    duration INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);
