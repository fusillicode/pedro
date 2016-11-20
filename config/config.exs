# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pedro,
  ecto_repos: [Pedro.Repo]

# Configures the endpoint
config :pedro, Pedro.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HQ3+33u2jRmpY49PssDq0dkw9vEb37H9L05GdJKyu+nO9gUQlZzTCXczGJOYQ0am",
  render_errors: [view: Pedro.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pedro.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
