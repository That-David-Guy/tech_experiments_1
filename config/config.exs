# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tech_experiments_1,
  ecto_repos: [TechExperiments1.Repo]

# Configures the endpoint
config :tech_experiments_1, TechExperiments1Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HDnAn1SFrKAaG2RyhiYly51PUq1jZ171jhl18unFi34FNPZ4RGi5gBNvzWfNCBY/",
  render_errors: [view: TechExperiments1Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TechExperiments1.PubSub,
  live_view: [signing_salt: "0+D1fBOz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
