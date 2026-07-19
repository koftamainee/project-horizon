CREATE ROLE kernel_auth WITH LOGIN PASSWORD '${KERNEL_AUTH_PASSWORD}';
CREATE ROLE kernel_profile WITH LOGIN PASSWORD '${KERNEL_PROFILE_PASSWORD}';
CREATE ROLE kernel_stream WITH LOGIN PASSWORD '${KERNEL_STREAM_PASSWORD}';
CREATE ROLE kernel_follow WITH LOGIN PASSWORD '${KERNEL_FOLLOW_PASSWORD}';
CREATE ROLE kernel_vod WITH LOGIN PASSWORD '${KERNEL_VOD_PASSWORD}';

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE CONNECT ON DATABASE horizon FROM PUBLIC;
GRANT CONNECT ON DATABASE horizon TO app_admin, kernel_auth, kernel_profile, kernel_stream, kernel_follow, kernel_vod;

CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS profile;
CREATE SCHEMA IF NOT EXISTS stream;
CREATE SCHEMA IF NOT EXISTS follow;
CREATE SCHEMA IF NOT EXISTS vod;

ALTER ROLE kernel_auth SET search_path = auth, public;
GRANT USAGE ON SCHEMA auth TO kernel_auth;
ALTER DEFAULT PRIVILEGES IN SCHEMA auth GRANT ALL ON TABLES TO kernel_auth;

ALTER ROLE kernel_profile SET search_path = profile, public;
GRANT USAGE ON SCHEMA profile TO kernel_profile;
ALTER DEFAULT PRIVILEGES IN SCHEMA profile GRANT ALL ON TABLES TO kernel_profile;

ALTER ROLE kernel_stream SET search_path = stream, public;
GRANT USAGE ON SCHEMA stream TO kernel_stream;
ALTER DEFAULT PRIVILEGES IN SCHEMA stream GRANT ALL ON TABLES TO kernel_stream;

ALTER ROLE kernel_follow SET search_path = follow, public;
GRANT USAGE ON SCHEMA follow TO kernel_follow;
ALTER DEFAULT PRIVILEGES IN SCHEMA follow GRANT ALL ON TABLES TO kernel_follow;

ALTER ROLE kernel_vod SET search_path = vod, public;
GRANT USAGE ON SCHEMA vod TO kernel_vod;
ALTER DEFAULT PRIVILEGES IN SCHEMA vod GRANT ALL ON TABLES TO kernel_vod;
