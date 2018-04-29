# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :apiEvaluto,
  ecto_repos: [ApiEvaluto.Repo]

# Configures the endpoint
config :apiEvaluto, ApiEvalutoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XCIPJ5/4qTYNowo2aM8IcotonDEh3orgfYtkaTyORnN6OruphSM9H3yWQ+9MUcfU",
  render_errors: [view: ApiEvalutoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiEvaluto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian config
config :apiEvaluto, ApiEvaluto.Guardian, 
  issuer: "apiEvaluto",
  secret_key: "0SQc6sR5y59JXt69+pRUXgpUOTJyU+QFl4ef3t3Coc9qAEQxyIeVrRF3bMs8PoNC"  

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
