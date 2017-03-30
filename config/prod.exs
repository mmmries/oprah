use Mix.Config

listen_port = case System.get_env("LISTEN_PORT") do
  nil -> 4000
  str -> String.to_integer(str)
end

public_port = case System.get_env("PUBLIC_PORT") do
  nil -> 443
  str -> String.to_integer(str)
end

public_host = System.get_env("HOST") || "oprah.riesd.com"

secret_key_base = System.get_env("SECRET_KEY_BASE")

repo_username = System.get_env("REPO_USERNAME")
repo_password = System.get_env("REPO_PASSWORD")
repo_database = System.get_env("REPO_DATABASE")
repo_hostname = System.get_env("REPO_HOSTNAME")

auth_client_id = System.get_env("AUTH_CLIENT_ID")
auth_client_secret = System.get_env("AUTH_CLIENT_SECRET")
auth_site = System.get_env("AUTH_SITE")
auth_authorize_url = System.get_env("AUTH_AUTHORIZE_URL")
auth_token_url = System.get_env("AUTH_TOKEN_URL")

config :oprah, Oprah.Endpoint,
  http: [port: listen_port],
  url: [host: public_host, port: public_port],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: secret_key_base

config :oprah, Oprah.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: repo_username,
  password: repo_password,
  database: repo_database,
  hostname: repo_hostname,
  pool_size: 4,
  ssl: true

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: auth_client_id,
  client_secret: auth_client_secret,
  site: auth_site,
  authorize_url: auth_authorize_url,
  token_url: auth_token_url

# Do not print debug messages in production
config :logger, level: :info

