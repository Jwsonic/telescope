defmodule Telescope.Matches do
  alias Telescope.{Heroes, ProPlayers}

  require Logger

  @type player ::
          {match_id :: non_neg_integer(), player :: String.t(), hero :: String.t(), DateTime.t()}

  @spec fetch(seq_num :: non_neg_integer()) ::
          {:ok, non_neg_integer(), list(player())} | {:error, String.t()}
  def fetch(seq_num) do
    url = build_url(seq_num)

    with {:ok, {{_http_version, 200, _reason}, _headers, body}} <-
           :httpc.request(url),
         body <- to_string(body),
         {:ok, result} <- Jason.decode(body) do
      matches =
        result
        |> Map.get("result", %{})
        |> Map.get("matches", [])

      datetime =
        matches
        |> Enum.map(fn match ->
          Map.get(match, "start_time", 0) + Map.get(match, "duration", 0)
        end)
        |> Enum.reduce(0, &max/2)
        |> DateTime.from_unix!()
        |> DateTime.shift_zone!("America/Los_Angeles", Tzdata.TimeZoneDatabase)
        |> DateTime.to_string()

      Logger.info("Match time: #{datetime}.")

      seq_num = matches |> next_seq_num() |> max(seq_num)
      matches = Enum.flat_map(matches, &extract_players/1)

      {:ok, seq_num, matches}
    else
      {:ok, {{_http_version, status, _reason}, _headers, _body}} ->
        {:error, "Got non-200 status code: #{status}."}

      {:error, %Jason.DecodeError{} = exception} ->
        {:error, Jason.DecodeError.message(exception)}

      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  @spec next_seq_num(matches :: list(map())) :: non_neg_integer()
  defp next_seq_num(matches) do
    matches |> Enum.map(&Map.get(&1, "match_seq_num", 0)) |> Enum.reduce(0, &max/2)
  end

  defp build_url(start_id) do
    ("https://api.steampowered.com/IDOTA2Match_570/GetMatchHistoryBySequenceNum/v0001/" <>
       "?key=6E4A91A7C018C1742D26EB81178ED01D" <>
       "&start_at_match_seq_num=#{start_id}")
    |> String.to_charlist()
  end

  defp extract_players(%{"match_id" => match_id, "players" => players, "start_time" => start_time}) do
    start_time = DateTime.from_unix(start_time)

    players
    |> Enum.filter(&Map.has_key?(&1, "account_id"))
    |> Enum.map(fn %{"account_id" => account_id} = player ->
      handle = account_id |> ProPlayers.get_player() |> Map.get("name")

      case handle do
        nil -> player
        handle -> Map.put(player, "handle", handle)
      end
    end)
    |> Enum.filter(&Map.has_key?(&1, "handle"))
    |> Enum.filter(&Map.has_key?(&1, "hero_id"))
    |> Enum.map(fn %{"handle" => name, "hero_id" => hero_id} ->
      {match_id, name, Heroes.get_name(hero_id), start_time}
    end)
  end
end
