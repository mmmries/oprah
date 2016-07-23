FROM hqmq/docker-elixir:1.3.1.0

ADD . /oprah
WORKDIR /oprah
ENV MIX_ENV prod
RUN mix local.hex --force && mix local.rebar --force && mix deps.get --only prod && mix compile && mix phoenix.digest

CMD mix phoenix.server
