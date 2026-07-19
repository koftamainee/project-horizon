FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY cmd/vod-assembler/main.go ./cmd/vod-assembler/

RUN go build -o /vod-assembler ./cmd/vod-assembler/main.go

FROM alpine:3.20

COPY --from=builder /vod-assembler /vod-assembler

CMD ["/vod-assembler"]
