defmodule Telescope.Datastore do
  @table 'pro_matches'

  @seq_num_key :seq_num

  alias Telescope.Matches

  def init do
    :dets.open_file(@table, type: :bag)
  end

  @spec write_players(list(Matches.player())) :: :ok
  def write_players([]), do: :ok

  def write_players(players) do
    :dets.insert(@table, players)

    :ok
  end

  @spec write_seq_num(seq_num :: non_neg_integer()) :: :ok
  def write_seq_num(seq_num) do
    :dets.delete(@table, @seq_num_key)
    :dets.insert_new(@table, {@seq_num_key, seq_num})

    :ok
  end

  @spec seq_num() :: non_neg_integer()
  def seq_num do
    case :dets.lookup(@table, @seq_num_key) do
      [{@seq_num_key, seq_num}] -> seq_num
      _ -> 4_595_976_092
    end
  end
end
