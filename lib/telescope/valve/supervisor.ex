defmodule Telescope.Valve.Supervisor do
  use Supervisor

  alias Telescope.Valve.MatchFetchServer

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      MatchFetchServer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
