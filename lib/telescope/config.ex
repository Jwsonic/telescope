defmodule Telescope.Config do
  @moduledoc """
  Config sets up the global configureation for the Telescope app.
  """
  use Skogsra

  @envdoc """
  Postgres database name.
  """
  app_env(:postgres_database, :telescope, [:database], default: "telescope")

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

  app_env(:http_host, :telescope, [:url, :host],
    default: "localhost",
    namespace: TelescopeWeb.Endpoint
  )

  @envdoc """
  HTTP server port
  """
  app_env(:http_port, :telescope, [:http, :port], default: 4000)

  app_env(
    :secret_key_base,
    :telescope,
    :secret_key_base,
    default: "gtndnT8nkLwbDyNFuf5RdSD4U2jiFVfsi//9IyjxvKjF0L0vMFibrL5vveYU0ur+"
  )

  app_env(:signing_salt, :telescope, [:live_view, :signing_salt], default: "FRpHmxju")

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

  # Skogsra puts every config into all namespaces which screws up a few configs.
  # So we manually unload those configs after the main config load.
  @unset [
    {:telescope, Telescope.Repo, :url},
    {:telescope, TelescopeWeb.Endpoint, :port}
  ]

  def preload_all do
    preload(Telescope.Repo)
    preload(TelescopeWeb.Endpoint)

    Enum.each(@unset, &unset_env/1)

    validate!()
  end

  defp unset_env({app, key, child_key}) do
    config =
      app
      |> Application.get_env(key)
      |> Keyword.delete(child_key)

    Application.put_env(app, key, config)
  end
end
