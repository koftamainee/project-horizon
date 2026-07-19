FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY cmd/streaming-control-plane/main.go ./cmd/streaming-control-plane/

RUN go build -o /streaming-control-plane ./cmd/streaming-control-plane/main.go

FROM alpine:3.20

COPY --from=builder /streaming-control-plane /streaming-control-plane

CMD ["/streaming-control-plane"]
