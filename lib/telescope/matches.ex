defmodule Telescope.Matches do
  @moduledoc """
  Match domain API.
  """
  alias Ecto.Changeset
  alias Telescope.Matches.{Datastore, Events, Match}

  require Logger

  @doc """
  Returns the current match_seq_num.
  """
  @spec get_match_seq_num() :: non_neg_integer()
  def get_match_seq_num do
    Datastore.get_match_seq_num()
  end

  @spec get_matches() :: list(Match.t())
  def get_matches do
    Datastore.get_matches()
  end

  @doc """
  Attempts to parse list of maps into `Telescope.Matches.Match`s. Successfully parsed
  matches are presisted and broadcast as events. The largest match sequence number is also persisted,
  regardless of if it's match is persisted.
  """
  @spec process(matches :: list(map())) :: :ok
  def process(matches) when is_list(matches) do
    process_match_seq_num(matches)

    process_matches(matches)

    :ok
  end

  def subscribe, do: Events.subscribe()

  defp process_matches(matches) do
    matches
    |> Enum.map(&Match.parse/1)
    |> Enum.filter(&valid?/1)
    |> Enum.filter(&notable_players?/1)
    |> Enum.map(&Datastore.write_match/1)
    |> Enum.each(&announce_result/1)
  end

  defp process_match_seq_num(matches) do
    matches
    |> Enum.filter(&is_map/1)
    |> Enum.map(&match_seq_num/1)
    |> Enum.reduce(0, &max/2)
    |> Datastore.write_match_seq_num()
  end

  defp valid?(%Changeset{valid?: valid}), do: valid

  defp notable_players?(changeset) do
    radiant_players = Changeset.get_field(changeset, :radiant_players, [])
    dire_players = Changeset.get_field(changeset, :dire_players, [])

    radiant_players != [] or dire_players != []
  end

  defp match_seq_num(data), do: Map.get(data, "match_seq_num", 0)

  defp announce_result({:ok, match}) do
    Events.broadcast(match)
  end

  defp announce_result({:error, %Changeset{errors: errors} = changeset}) do
    match_id = Changeset.get_field(changeset, :match_id, :unknown)

    Logger.error("Error writing match: #{inspect(errors)}", match_id: match_id)
  end
end
