CREATE TABLE vod.vods (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    stream_id UUID UNIQUE NOT NULL REFERENCES stream.streams(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    status TEXT NOT NULL DEFAULT 'assembling' CHECK (status IN ('assembling', 'ready', 'failed')),
    manifest_path TEXT,
    thumbnail_path TEXT,
    duration INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_vods_user_id ON vod.vods (user_id);

CREATE TRIGGER trg_vods_updated_at
    BEFORE UPDATE ON vod.vods
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
