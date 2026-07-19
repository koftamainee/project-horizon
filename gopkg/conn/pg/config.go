package pg

import "time"

type Config struct {
	DSN             string
	MaxOpenConns    int           `default:"10"`
	MaxIdleConns    int           `default:"5"`
	ConnMaxLifetime time.Duration `default:"30m"`
}
