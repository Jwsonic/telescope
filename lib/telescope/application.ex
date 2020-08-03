defmodule Telescope.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Telescope.Config.preload_all()

    :inets.start()
    :ssl.start()

    children = [
      {Finch, name: FinchHttp},
      Telescope.Repo,
      Telescope.Heroes,
      Telescope.ProPlayers,
      Telescope.Valve.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Telescope.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
