import Config

config :telescope,
  ecto_repos: [Telescope.Repo]

# Configures the endpoint
config :telescope, TelescopeWeb.Endpoint,
  render_errors: [view: TelescopeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Telescope.PubSub

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

env = Mix.env()

if env in [:dev, :test], do: import_config("#{env}.exs")
