defmodule Telescope.MatchWatcher.Worker do
  use GenServer

  require Logger

  alias Telescope.{Datastore, Matches}

  # 4 second interval
  @fetch_interval 4_000

  def start_link(start_id) do
    GenServer.start_link(__MODULE__, start_id, name: __MODULE__)
  end

  def init(_start_id) do
    Datastore.init()

    Process.send_after(__MODULE__, :fetch_matches, @fetch_interval)

    {:ok, Datastore.seq_num()}
  end

  def handle_info(:fetch_matches, seq_num) do
    next_seq_num =
      case Matches.fetch(seq_num) do
        {:error, reason} ->
          Logger.error(reason)
          seq_num

        {:ok, next_seq_num, players} ->
          Enum.each(players, fn {_match_id, player, hero, _time} ->
            Logger.info("Found match with #{player} playing #{hero}.")
          end)

          Datastore.write_players(players)
          max(seq_num, next_seq_num)
      end

    # Logger.info("Seq num: #{next_seq_num}")

    Datastore.write_seq_num(next_seq_num)

    Process.send_after(__MODULE__, :fetch_matches, @fetch_interval)

    {:noreply, next_seq_num}
  end
end
