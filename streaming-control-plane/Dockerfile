FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.work go.work.sum ./

COPY gopkg/config/go.mod gopkg/config/go.sum ./gopkg/config/
COPY gopkg/conn/minio/go.mod gopkg/conn/minio/go.sum ./gopkg/conn/minio/
COPY gopkg/conn/nats/go.mod gopkg/conn/nats/go.sum ./gopkg/conn/nats/
COPY gopkg/conn/pg/go.mod gopkg/conn/pg/go.sum ./gopkg/conn/pg/
COPY gopkg/http/go.mod gopkg/http/go.sum ./gopkg/http/
COPY gopkg/json/go.mod gopkg/json/go.sum ./gopkg/json/
COPY gopkg/log/go.mod gopkg/log/go.sum ./gopkg/log/
COPY gopkg/proto/go.mod gopkg/proto/go.sum ./gopkg/proto/
COPY gopkg/retry/go.mod gopkg/retry/go.sum ./gopkg/retry/
COPY gopkg/shutdown/go.mod gopkg/shutdown/go.sum ./gopkg/shutdown/
COPY streaming-control-plane/go.mod ./streaming-control-plane/

RUN go mod download

COPY gopkg/ ./gopkg/
COPY streaming-control-plane/ ./streaming-control-plane/

RUN go build -o /streaming-control-plane ./streaming-control-plane/cmd/streaming-control-plane/main.go

FROM alpine:3.20

COPY --from=builder /streaming-control-plane /streaming-control-plane

CMD ["/streaming-control-plane"]
