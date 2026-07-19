package nats

const (
	StreamStreamEvents   = "STREAM_EVENTS"
	StreamTranscodeTasks = "TRANSCODE_TASKS"
	StreamVodEvents      = "VOD_EVENTS"
)

const (
	SubjectStreamStarted      = "stream.started"
	SubjectStreamEnded        = "stream.ended"
	SubjectTranscodeStart     = "transcode.start"
	SubjectTranscodeStop      = "transcode.stop"
	SubjectTranscodeHeartbeat = "transcode.heartbeat"
	SubjectVodAssemble        = "vod.assemble"
	SubjectVodReady           = "vod.ready"
)

const (
	ConsumerStreamEvents   = "stream-events-consumer"
	ConsumerTranscodeTasks = "transcode-tasks-consumer"
	ConsumerVodEvents      = "vod-events-consumer"
	ConsumerVodReady       = "vod-ready-consumer"
	ConsumerHeartbeat      = "heartbeat-consumer"
)
