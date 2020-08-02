defmodule Telescope.Valve.MatchFetchServer do
  use GenServer

  alias Telescope.Valve.Impl

  @spec start_link(args :: []) :: GenServer.on_start()
  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_args) do
    Impl.init()

    {:ok, :no_state}
  end

  @impl true
  def handle_info(:fetch, state) do
    Impl.fetch()

    {:noreply, state}
  end
end
