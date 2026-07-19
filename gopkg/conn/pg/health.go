package pg

import (
	"context"

	"github.com/jackc/pgx/v5/pgxpool"
)

func HealthCheck(pool *pgxpool.Pool) func(ctx context.Context) error {
	return func(ctx context.Context) error {
		return pool.Ping(ctx)
	}
}
