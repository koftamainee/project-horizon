package nats

import (
	"context"

	"github.com/nats-io/nats.go/jetstream"
	"google.golang.org/protobuf/proto"
)

func Publish(ctx context.Context, js jetstream.JetStream, subject string, msg proto.Message) error {
	b, err := proto.Marshal(msg)
	if err != nil {
		return err
	}
	_, err = js.Publish(ctx, subject, b)
	return err
}
