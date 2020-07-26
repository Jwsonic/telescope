import Config

config :telescope,
  ecto_repos: [Telescope.Repo]

config :telescope, Telescope.Repo,
  database: "telescope",
  username: "telescope",
  password: "password",
  hostname: "localhost",
  port: "4001"

if Mix.env() == :test, do: import_config("test.exs")
