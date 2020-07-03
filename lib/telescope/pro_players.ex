defmodule Telescope.ProPlayers do
  use Agent

  require Logger

  def start_link(_args) do
    Agent.start_link(&fetch_players/0, name: __MODULE__)
  end

  @spec get_player(account_id :: String.t()) :: map()
  def get_player(account_id) do
    __MODULE__
    |> Agent.get(& &1)
    |> Map.get(account_id, %{})
  end

  defp fetch_players do
    with {:ok, {{_http_version, 200, _reason}, _headers, body}} <-
           :httpc.request('https://api.opendota.com/api/proPlayers'),
         body <- to_string(body),
         {:ok, players} <- Jason.decode(body) do
      Logger.info("Got #{length(players)} players.")

      Enum.reduce(players, %{}, fn player, acc ->
        key = Map.get(player, "account_id", "no_id")

        Map.put(acc, key, player)
      end)
    else
      _ -> %{}
    end
  end
end
