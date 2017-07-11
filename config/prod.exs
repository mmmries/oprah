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

config :oprah, :event_file, "/opt/db/prod.jsonstream"

config :ueberauth, Ueberauth.Strategy.Gitlab.OAuth,
  client_id: auth_client_id,
  client_secret: auth_client_secret,
  site: auth_site,
  authorize_url: auth_authorize_url,
  token_url: auth_token_url

# Do not print debug messages in production
config :logger, level: :info
