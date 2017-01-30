use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :oprah, Oprah.Endpoint,
  http: [port: 4000],
  debug_errors: false,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :oprah, Oprah.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :oprah, Oprah.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "oprah_dev",
  hostname: "localhost",
  pool_size: 10

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: String.trim(File.read!(".github_client_id")),
  client_secret: String.trim(File.read!(".github_client_secret")),
  site: "https://git.moneydesktop.com/api/v3",
  authorize_url: "https://git.moneydesktop.com/login/oauth/authorize",
  token_url: "https://git.moneydesktop.com/login/oauth/access_token"
