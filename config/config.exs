# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SBx9pAe0Dw44azYuejDzR/I5jMenjvdq+Wkh8HCxp5a7K8kBUwxBK/tbUtAluaCI",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config :ueberauth, Ueberauth,
#   providers: [
#     github: {Ueberauth.Strategy., []},
#     facebook: {Ueberauth.Strategy.Facebook, []}
#   ]

# config :ueberauth, Ueberauth.Strategy.Github.OAuth,
#   client_id: System.get_env("GITHUB_CLIENT_ID"),
#   client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
#   client_id: System.get_env("FACEBOOK_CLIENT_ID"),
#   client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
