defmodule Telescope.Config do
  @moduledoc """
  Config sets up the global configureation for the Telescope app.
  """
  use Skogsra

  def preload_all do
    preload(Telescope.Repo)

    validate!()
  end

  @envdoc """
  Postgres database name.
  """
  app_env(:postgres_name, :telescope, [:database], default: "telescope")

  @envdoc """
  Postgres user name
  """
  app_env(:postgres_user, :telescope, [:username], default: "telescope")

  @envdoc """
  Postgres password
  """
  app_env(:postgres_password, :telescope, [:password], default: "password")

  @envdoc """
  Postgres hostname
  """
  app_env(:postgres_hostname, :telescope, [:hostname], default: "localhost")

  @envdoc """
  Postgres port
  """
  app_env(:postgres_port, :telescope, [:port], default: "4001")

  @envdoc """
  Key for Valve APIs
  """
  app_env(:valve_api_key, :telescope, [:valve_api_key], default: "key")

  @envdoc """
  Base URL for Valve APIs
  """
  app_env(:valve_base_url, :telescope, [:valve_base_url],
    default: "https://api.steampowered.com/IDOTA2Match_570/"
  )
end
