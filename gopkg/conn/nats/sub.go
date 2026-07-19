package nats

import (
	"context"

	"github.com/nats-io/nats.go/jetstream"
	"google.golang.org/protobuf/proto"
)

type SubscribeConfig struct {
	Stream     string
	Name       string
	Subjects   []string
	MaxDeliver int
	AckPolicy  jetstream.AckPolicy
	Group      string
}

func Subscribe[T proto.Message](
	ctx context.Context,
	js jetstream.JetStream,
	cfg SubscribeConfig,
	handler func(T) error,
) error {
	consumerCfg := jetstream.ConsumerConfig{
		Durable:        cfg.Name,
		FilterSubjects: cfg.Subjects,
		MaxDeliver:     cfg.MaxDeliver,
		AckPolicy:      cfg.AckPolicy,
	}

	consumer, err := js.CreateOrUpdateConsumer(ctx, cfg.Stream, consumerCfg)
	if err != nil {
		return err
	}

	_, err = consumer.Consume(func(raw jetstream.Msg) {
		var msg T
		if err := proto.Unmarshal(raw.Data(), msg); err != nil {
			_ = raw.Nak()
			return
		}

		if err := handler(msg); err != nil {
			_ = raw.Nak()
			return
		}
		_ = raw.Ack()
	})
	return err
}
