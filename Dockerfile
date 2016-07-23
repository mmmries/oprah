FROM elixir:1.3.2

ADD . /oprah
WORKDIR /oprah
RUN mix local.hex --force
RUN mix local.rebar --force
ENV MIX_ENV prod
RUN mix deps.get --only prod
RUN mix compile
RUN mix phoenix.digest

CMD mix phoenix.server
