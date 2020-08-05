defmodule Telescope.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Telescope.Config.preload_all()
    Telescope.Heroes.load()

    children =
      [
        {Finch, name: FinchHttp},
        Telescope.Repo
      ]
      |> env_children(Mix.env())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Telescope.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp env_children(children, :test), do: children

  defp env_children(children, _env) do
    children ++ [Telescope.ProPlayers, Telescope.Valve.Supervisor]
  end
end
