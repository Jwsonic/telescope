defmodule Telescope.Matches.SeqNum do
  @moduledoc """
  Represents the current match sequence number. Intended to only ever be a single row table.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @type t() :: %SeqNum{
          id: non_neg_integer(),
          match_seq_num: non_neg_integer(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "seq_num" do
    field(:match_seq_num, :integer)

    timestamps(type: :utc_datetime)
  end

  @spec changeset(seq_num :: SeqNum.t() | nil, changes :: map()) :: Ecto.Changeset.t()
  def changeset(seq_num, changes) when is_map(changes) do
    seq_num
    |> Kernel.||(%SeqNum{})
    |> cast(changes, [:match_seq_num])
    |> validate_number(:match_seq_num, greater_than: 0)
    |> unique_constraint(:match_seq_num)
  end
end
