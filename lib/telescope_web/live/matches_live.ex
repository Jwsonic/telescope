defmodule TelescopeWeb.MatchesLive do
  use TelescopeWeb, :live_view

  alias Telescope.Matches

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, matches: Matches.get_matches())}
  end
end
