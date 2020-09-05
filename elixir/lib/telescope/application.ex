defmodule Telescope.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Telescope.Config.preload_all()
    Telescope.Heroes.load!()
    Telescope.ProPlayers.load!()

    children =
      [
        {Finch, name: FinchHttp},
        TelescopeWeb.Telemetry,
        # Start the PubSub system
        {Phoenix.PubSub, name: Telescope.PubSub},
        # Start the Endpoint (http/https)
        Telescope.Repo,
        TelescopeWeb.Endpoint
      ]
      |> env_children(Mix.env())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Telescope.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TelescopeWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp env_children(children, :test), do: children

  defp env_children(children, _env) do
    children ++ [Telescope.Valve.Supervisor]
  end
end
