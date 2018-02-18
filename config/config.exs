# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :screener,
  ecto_repos: [Screener.Repo]

# Configures the endpoint
config :screener, ScreenerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gQjh2Br4VzRKlPBTfgLz6xjqKzKFjQi5I0ZaChDSoo9k00TW6EhYuS4Dxyy0eRQh",
  render_errors: [view: ScreenerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Screener.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
