defmodule Telescope.Games.Player do
  defstruct hero: "", name: ""

  @type t() :: %__MODULE__{
          hero: String.t(),
          name: String.t()
        }
end

defmodule Telescope.Games.Game do
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__
  alias Ecto.Changeset

  @type t() :: %Game{
          duration: non_neg_integer(),
          match_id: non_neg_integer(),
          match_seq_num: non_neg_integer(),
          radiant_win: boolean(),
          start_time: DateTime.t()
        }

  schema "games" do
    field(:duration, :integer)
    field(:match_id, :integer)
    field(:match_seq_num, :integer)
    field(:radiant_win, :boolean)
    field(:start_time, :utc_datetime)

    timestamps(type: :utc_datetime)
  end

  @params [:duration, :match_id, :match_seq_num, :radiant_win, :start_time]

  @doc """
  Attempts to parse a `Game` from a given map.
  """
  @spec parse(data :: map()) :: Changeset.t()
  def parse(data) when is_map(data) do
    data
    |> convert_start_time()
    |> (&cast(%Game{}, &1, @params)).()
    |> validate_required(@params)
    |> validate_number(:duration, greater_than: 0)
    |> validate_number(:match_id, greater_than: 0)
    |> unique_constraint(:match_id)
    |> validate_number(:match_seq_num, greater_than: 0)
    |> unique_constraint(:match_seq_num)
  end

  defp convert_start_time(%{"start_time" => start_time} = data)
       when is_integer(start_time) and start_time > 0 do
    start_time
    |> DateTime.from_unix!()
    |> (&Map.put(data, "start_time", &1)).()
  end

  defp convert_start_time(data), do: data
end
