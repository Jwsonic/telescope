defmodule Telescope.Matches.Datastore do
  @moduledoc """
  Datastore is responsible for presisting data in the Matches domain.
  """
  require Logger

  alias Ecto.Changeset
  alias Telescope.Matches.{Match, SeqNum}
  alias Telescope.Repo

  import Ecto.Query

  @doc """
  Persists a `Match`.
  """
  @spec write_match(changeset :: Changeset.t()) :: {:ok, Match.t()} | {:error, Ecto.Changeset.t()}
  def write_match(%Changeset{data: %Match{}} = changeset) do
    Repo.insert(changeset)
  end

  @doc """
  Persists the given match_seq_num.
  """
  @spec write_match_seq_num(match_seq_num :: non_neg_integer()) ::
          {:ok, SeqNum.t()} | {:error, Ecto.Changeset.t()}
  def write_match_seq_num(match_seq_num) do
    Logger.info("Writing #{match_seq_num}.")

    SeqNum
    |> limit(1)
    |> Repo.one()
    |> SeqNum.changeset(%{match_seq_num: match_seq_num})
    |> Repo.insert_or_update()
  end

  @doc """
  Returns the current match_seq_num.
  """
  @spec get_match_seq_num() :: non_neg_integer()
  def get_match_seq_num do
    SeqNum
    |> limit(1)
    |> Repo.one()
    |> Kernel.||(%{})
    |> Map.get(:match_seq_num, 4_595_976_092)
  end
end
