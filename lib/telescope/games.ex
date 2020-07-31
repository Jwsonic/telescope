defmodule Telescope.Games do
  alias Ecto.Changeset
  alias Telescope.Games.{Datastore, Game}

  require Logger

  @doc """
  Returns the current match_seq_num.
  """
  @spec get_match_seq_num() :: non_neg_integer()
  def get_match_seq_num do
    Datastore.get_match_seq_num()
  end

  @spec process(games :: list(map())) :: :ok
  def process(games) when is_list(games) do
    process_match_seq_num(games)

    process_games(games)
  end

  defp process_games(games) do
    games
    |> Enum.map(&Game.parse/1)
    |> Enum.filter(&valid?/1)
    |> Enum.filter(&notable_players?/1)
    |> Enum.map(&Datastore.write_game/1)
    |> Enum.each(&announce_result/1)
  end

  defp process_match_seq_num(games) do
    games
    |> Enum.filter(&is_map/1)
    |> Enum.map(&match_seq_num/1)
    |> Enum.reduce(&max/2)
    |> Kernel.||(0)
    |> Datastore.write_match_seq_num()
  end

  defp valid?(data), do: Map.get(data, :valid?, false)

  defp notable_players?(_data), do: false

  defp match_seq_num(data), do: Map.get(data, :match_seq_num, 0)

  defp announce_result({:ok, game}) do
    game
  end

  defp announce_result({:error, %Changeset{errors: errors} = changeset}) do
    match_id = Changeset.get_field(changeset, :match_id, :unknown)

    Logger.error("Error writing game: #{inspect(errors)}", match_id: match_id)
  end
end
