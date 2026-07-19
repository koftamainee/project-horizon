CREATE TABLE stream.categories (
    id UUID PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE stream.streams (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT,
    category_id UUID REFERENCES stream.categories(id),
    status TEXT NOT NULL DEFAULT 'idle' CHECK (status IN ('idle', 'live', 'ended')),
    started_at TIMESTAMPTZ,
    ended_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_streams_user_id ON stream.streams (user_id);

CREATE TRIGGER trg_streams_updated_at
    BEFORE UPDATE ON stream.streams
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
