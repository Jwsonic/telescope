defmodule Telescope.Games.SeqNum do
  @moduledoc """
  Represents the current match sequence number. Intended to only ever be a single row table.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @id 1

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

  def changeset(match_seq_num) do
    %__MODULE__{id: @id}
    |> cast(%{match_seq_num: match_seq_num}, [:match_seq_num])
    |> validate_number(:match_seq_num, greater_than: 0)
  end
end
