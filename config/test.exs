use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pedro, Pedro.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pedro, Pedro.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: "el0pm3nt",
  database: "pedro_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Pedro",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: %{"k" => "gM4_NylU_S551ZWyXTqozL5HnIwGcKw9rgtcTiKpXOEkoKGqY2pqJZUVDrDUIDK5bjw4_CA8fNjvWHuW1tCJDQ", "kty" => "oct"},
  serializer: Pedro.GuardianSerializer
