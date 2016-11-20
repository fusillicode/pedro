use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :pedro, Pedro.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :pedro, Pedro.Endpoint,
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
config :pedro, Pedro.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: "el0pm3nt",
  database: "pedro_dev",
  hostname: "localhost",
  pool_size: 10

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Pedro",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: %{"k" => "gM4_NylU_S551ZWyXTqozL5HnIwGcKw9rgtcTiKpXOEkoKGqY2pqJZUVDrDUIDK5bjw4_CA8fNjvWHuW1tCJDQ", "kty" => "oct"},
  serializer: Pedro.GuardianSerializer
