defmodule Telescope.Matches.MatchPlayer do
  use Ecto.Schema

  import Ecto.Changeset
  import Telescope.ProPlayers, only: [is_pro_player?: 2]

  alias __MODULE__
  alias Telescope.Heroes
  alias Telescope.Matches.Match
  alias Telescope.ProPlayers

  @type t() :: %MatchPlayer{
          hero: String.t(),
          id: non_neg_integer(),
          inserted_at: DateTime.t(),
          name: String.t(),
          radiant?: boolean(),
          updated_at: DateTime.t()
        }

  schema "match_players" do
    field(:hero, :string)
    field(:name, :string)
    field(:radiant?, :boolean, default: true)

    belongs_to(:match, Match)

    timestamps(type: :utc_datetime)
  end

  @doc """
  Attempts to parse a `MatchPlayer` from a map.
  """
  @spec parse(data :: map()) :: Ecto.Changeset.t()
  def parse(data) when is_map(data) do
    data
    |> extract_account_id()
    |> build_changeset(data, ProPlayers.all())
  end

  defp extract_account_id(data), do: Map.get(data, "account_id", 0)

  def build_changeset(account_id, data, players) when is_pro_player?(players, account_id) do
    changes = %{
      hero: extract_hero(data),
      name: extract_name(data),
      radiant?: extract_radiant?(data)
    }

    %MatchPlayer{}
    |> change(changes)
    |> unique_constraint([:hero, :name])
    |> unique_constraint([:name, :match_id])
  end

  def build_changeset(_account_id, _data, _players), do: %Ecto.Changeset{valid?: false}

  defp extract_hero(%{"hero_id" => hero_id}) when is_integer(hero_id) do
    Heroes.name(hero_id)
  end

  defp extract_hero(_data), do: "Unknown"

  defp extract_name(%{"account_id" => account_id}) when is_integer(account_id) do
    ProPlayers.name(account_id)
  end

  defp extract_name(_data), do: "Unknown"

  @dire_start 128

  defp extract_radiant?(%{"player_slot" => player_slot}) when is_integer(player_slot) do
    player_slot < @dire_start
  end

  defp extract_radiant?(_data), do: true
end
