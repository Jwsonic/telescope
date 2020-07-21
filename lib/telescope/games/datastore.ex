defmodule Telescope.Games.Datastore do
  @table 'games'

  @game_key :game
  @seq_num_key :seq_num

  alias Telescope.Games.Game

  @spec init() :: :ok
  def init do
    :dets.open_file(@table, type: :ordered_set)

    :ok
  end

  @spec write_game(game :: Game.t()) :: :ok
  def write_game(%Game{seq_num: seq_num} = game) do
    :dets.insert(@table, {{@game_key, seq_num}, game})

    if seq_num > current_seq_num(), do: write_current_seq_num(seq_num)

    :ok
  end

  @spec current_seq_num() :: non_neg_integer()
  def current_seq_num do
    case :dets.match_object(@table, {@seq_num_key, :"$1"}) do
      [{@seq_num_key, seq_num}] -> seq_num
      _ -> 4_595_976_092
    end
  end

  @spec write_current_seq_num(seq_num :: non_neg_integer()) :: :ok
  defp write_current_seq_num(seq_num) do
    :dets.match_delete(@table, {@seq_num_key, :_})
    :dets.insert(@table, {@seq_num_key, seq_num})

    :ok
  end
end
