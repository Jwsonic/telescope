import Config

config :telescope, Telescope.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "telescope_test",
  username: "telescope",
  password: "password",
  port: "4001"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :telescope, TelescopeWeb.Endpoint, server: false

# Print only warnings and errors during test
config :logger, level: :warn
