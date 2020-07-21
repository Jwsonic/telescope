defmodule Telescope.Games.Player do
  defstruct hero: "", name: ""

  @type t() :: %__MODULE__{
          hero: String.t(),
          name: String.t()
        }
end

defmodule Telescope.Games.Game do
  defstruct dire_players: [],
            match_id: 0,
            radiant_players: [],
            start_time: DateTime.utc_now(),
            winner: :radiant,
            seq_num: 0

  alias Telescope.Games.Player

  @type side :: :radiant | :dire

  @type t() :: %__MODULE__{
          dire_players: list(Player.t()),
          match_id: non_neg_integer(),
          radiant_players: list(Player.t()),
          seq_num: non_neg_integer(),
          start_time: DateTime.t(),
          winner: side()
        }

  @doc """
  Attempts to parse a `Game` from a given map.
  """
  @spec parse(data :: map()) :: {:ok, Game.t()} | {:error, String.t()}
  def parse(%{"match_id" => match_id} = data) do
    with {:ok, _players} <- extract(data, "players"),
         {:ok, seq_num} <- extract(data, "match_seq_num"),
         {:ok, start_time} <- extract(data, "start_time"),
         {:ok, start_time} <- DateTime.from_unix(start_time),
         {:ok, radiant_win} <- extract(data, "radiant_win") do
      {:ok,
       %__MODULE__{
         match_id: match_id,
         seq_num: seq_num,
         start_time: start_time,
         winner: (radiant_win && :radiant) || :dire
       }}
    end
  end

  def parse(_data), do: {:error, "Missing match id."}

  defp extract(%{"match_id" => match_id} = data, key) do
    case Map.get(data, key) do
      nil -> {:error, "#{key} missing from #{match_id}."}
      value -> {:ok, value}
    end
  end
end
