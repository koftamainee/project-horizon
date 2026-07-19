package minio

type Config struct {
	Endpoint  string
	Region    string `default:"us-east-1"`
	AccessKey string
	SecretKey string
	Bucket    string
	UseSSL    bool `default:"false"`
}
