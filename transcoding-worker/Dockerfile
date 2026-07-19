FROM gcc:13-alpine AS builder

WORKDIR /app

COPY CMakeLists.txt ./
COPY src/ ./src/

RUN apk add --no-cache cmake && \
    mkdir build && cd build && \
    cmake .. && make

FROM alpine:3.20

RUN adduser -D -u 1001 appuser

COPY --from=builder /app/build/transcoding-worker /transcoding-worker

USER appuser

CMD ["/transcoding-worker"]
