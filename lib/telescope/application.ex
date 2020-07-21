defmodule Telescope.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Telescope.MatchWatcher.Worker, as: MatchWatchWorker

  def start(_type, _args) do
    :inets.start()
    :ssl.start()

    children = [
      Telescope.Heroes,
      Telescope.ProPlayers
      # MatchWatchWorker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Telescope.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
