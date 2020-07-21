defmodule Telescope.ProPlayers do
  use Agent

  require Logger

  @epoch ~U[1970-01-01 00:00:00Z]
  @one_year 60 * 60 * 24 * 365

  def start_link(_args) do
    Agent.start_link(&fetch_players/0, name: __MODULE__)
  end

  @spec get_player(account_id :: String.t()) :: map()
  def get_player(account_id) do
    __MODULE__
    |> Agent.get(&all_players/1)
    |> Map.get(account_id, %{})
  end

  def active_players do
    __MODULE__
    |> Agent.get(&all_players/1)
    |> Enum.filter(&is_pro?/1)
    |> Enum.filter(&active?/1)
    |> Enum.map(fn {_key, player} -> Map.get(player, "name") end)
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

  defp all_players(players), do: players

  defp active?({_key, player}) do
    player
    |> extract_last_match_time()
    |> DateTime.diff(DateTime.utc_now(), :second)
    |> abs()
    |> Kernel.<=(@one_year)
  end

  defp is_pro?({_key, player}) do
    Map.get(player, "is_pro", false)
  end

  defp extract_last_match_time(player) do
    last_match_timestamp = Map.get(player, "last_match_time", "")

    case DateTime.from_iso8601(last_match_timestamp) do
      {:ok, datetime, _offset} -> datetime
      {:error, _error} -> @epoch
    end
  end
end
