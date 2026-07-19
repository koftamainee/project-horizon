FROM golang:1.26-alpine AS builder

WORKDIR /app
ENV GOWORK=off

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
COPY vod-assembler/go.mod vod-assembler/go.sum ./vod-assembler/

RUN go mod download 2>/dev/null || true

COPY gopkg/ ./gopkg/
COPY vod-assembler/ ./vod-assembler/

RUN go build -o /vod-assembler ./vod-assembler/cmd/vod-assembler/main.go

FROM alpine:3.20

RUN adduser -D -u 1001 appuser

COPY --from=builder /vod-assembler /vod-assembler

USER appuser

CMD ["/vod-assembler"]
