# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eSalud,
  ecto_repos: [ESalud.Repo]

# Configures the endpoint
config :eSalud, ESalud.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rQ0qJ2JPasEwLd1AKA/dXfRM4XSokBSDlKpSwLdbPnf+J0WeKoi+SmENpazTYPst",
  render_errors: [view: ESalud.ErrorView, accepts: ~w(json)],
  pubsub: [name: ESalud.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
