package minio

import (
	"context"

	"github.com/minio/minio-go/v7"
)

func HealthCheck(client *minio.Client, bucket string) func(ctx context.Context) error {
	return func(ctx context.Context) error {
		exists, err := client.BucketExists(ctx, bucket)
		if err != nil {
			return err
		}
		if !exists {
			return ErrBucketNotFound
		}
		return nil
	}
}
