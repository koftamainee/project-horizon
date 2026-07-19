FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY cmd/kernel/main.go ./cmd/kernel/

RUN go build -o /kernel ./cmd/kernel/main.go

FROM alpine:3.20

COPY --from=builder /kernel /kernel

EXPOSE 8080

CMD ["/kernel"]
