FROM hqmq/alpine-elixir:0.1

ENV MIX_ENV=prod
RUN mix local.hex --force
RUN mix local.rebar --force
ADD . .
RUN mix do deps.get --only prod, compile, phoenix.digest

CMD mix phoenix.server
