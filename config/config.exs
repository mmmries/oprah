# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :oprah,
  ecto_repos: [Oprah.Repo]

# Configures the endpoint
config :oprah, Oprah.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H3kLe8ACX5kjlafBfsp78E+ChBwGbAn+HyW7eaQd4SSMD3L7JTBOQJQG7OKccNLZ",
  render_errors: [view: Oprah.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Oprah.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "", uid_field: :id]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
