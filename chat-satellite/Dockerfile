FROM elixir:1.20-alpine AS builder

WORKDIR /app

COPY mix.exs ./

RUN mix local.hex --force && mix local.rebar --force && mix deps.get

COPY lib/ ./lib/

RUN mix compile

FROM alpine:3.20

RUN apk add --no-cache erlang-runtime

COPY --from=builder /app/_build/dev/lib/chat_satellite/ebin /app/ebin

CMD ["elixir", "-e", "ChatSatellite.hello()"]
