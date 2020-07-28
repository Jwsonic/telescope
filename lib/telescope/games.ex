defmodule Telescope.Games do
  alias Telescope.Games.{Datastore, Game}

  require Logger

  @spec record(data :: map()) :: :ok
  def record(data) when is_map(data) do
    case Game.parse(data) do
      {:ok, game} ->
        Datastore.write_game(game)

      # TODO: Pubsub announce

      {:error, message} ->
        Logger.error(message)
    end
  end

  @spec latest(count :: non_neg_integer()) :: list(Game.t())
  def latest(_count \\ 50) do
    []
  end
end
