package nats

import (
	"context"
	"fmt"

	"github.com/nats-io/nats.go/jetstream"
)

func HealthCheck(js jetstream.JetStream) func(ctx context.Context) error {
	return func(ctx context.Context) error {
		if !js.Conn().IsConnected() {
			return fmt.Errorf("nats: not connected")
		}
		return nil
	}
}
