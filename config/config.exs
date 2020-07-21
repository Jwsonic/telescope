import Config

config :telescope,
  ecto_repos: [Telescope.Repo]

config :telescope, Telescope.Repo,
  database: "telescope_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"
