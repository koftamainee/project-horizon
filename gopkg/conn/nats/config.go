package nats

type Config struct {
	URL        string
	MaxDeliver int `default:"3"`
}
