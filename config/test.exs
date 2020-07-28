import Config

config :telescope, Telescope.Repo,
  database: "telescope_test",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :error
