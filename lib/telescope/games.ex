defmodule Telescope.Games do
  alias Telescope.Games.{Datastore, Game}

  @spec record(game :: Game.t()) :: :ok
  def record(game) do
    Datastore.write_game(game)

    # TODO: Pubsub announce
  end

  @spec latest(count :: non_neg_integer()) :: list(Game.t())
  def latest(_count \\ 50) do
    []
  end
end
