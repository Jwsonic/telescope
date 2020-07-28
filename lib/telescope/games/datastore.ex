defmodule Telescope.Games.Datastore do
  @moduledoc """
  Datastore is responsible for presisting data in the Games domain.
  """

  alias Ecto.Changeset
  alias Telescope.Games.Game
  alias Telescope.Repo

  import Ecto.Query

  @doc """
  Persists a `Game`.
  """
  @spec write_game(changeset :: Changeset.t()) :: {:ok, Game.t()} | {:error, Ecto.Changeset.t()}
  def write_game(%Changeset{data: %Game{}} = changeset) do
    Repo.insert(changeset)
  end

  @doc """
  Returns the current match_seq_num.
  """
  @spec current_match_seq_num() :: non_neg_integer()
  def current_match_seq_num do
    Game
    |> select([:match_seq_num])
    |> order_by(desc: :match_seq_num)
    |> limit(1)
    |> Repo.one()
    |> Kernel.||(%{})
    |> Map.get(:match_seq_num, 4_595_976_092)
  end
end
