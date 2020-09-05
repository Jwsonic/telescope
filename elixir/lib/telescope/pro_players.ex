defmodule Telescope.ProPlayers do
  @moduledoc """
  Pro player domain API.
  """
  require Logger

  @key __MODULE__
  @hero_file "pro_players.json"

  @type player :: String.t()
  @opaque cache :: %{required(integer()) => player()}

  @doc """
  Returns a `Telescope.ProPlayers.cache()` of all the current players. Intended to be
  used with Telescope.ProPlayers.is_pro_player?/2`.
  """
  @spec all() :: cache()
  def all do
    :persistent_term.get(@key, %{})
  end

  @doc """
  A guard that returns true if the given account id is a player in the given cache.
  """
  @spec is_pro_player?(players :: cache(), account_id :: integer()) :: Macro.t()
  defguard is_pro_player?(players, account_id)
           when is_map(players) and is_integer(account_id) and is_map_key(players, account_id)

  @doc """
  Returns the name for the given account_id is there is one. Otherwise
  it returns "Unknown".
  """
  @spec name(account_id :: integer()) :: String.t()
  def name(account_id) when is_integer(account_id) do
    @key
    |> :persistent_term.get()
    |> Map.get(account_id, "Unknown")
  end

  @doc """
  Loads pro player information into memory.
  """
  @spec load!() :: :ok
  def load! do
    :persistent_term.erase(@key)

    read_heroes!()
    |> Enum.reduce(%{}, &transform/2)
    |> persist()
  end

  defp read_heroes! do
    :telescope
    |> :code.priv_dir()
    |> Path.join(@hero_file)
    |> File.read!()
    |> Jason.decode!()
  end

  defp transform(%{"account_id" => id, "name" => name}, acc) do
    Map.put(acc, id, name)
  end

  defp transform(hero, acc) do
    Logger.error("Invalid player: #{inspect(hero)}")

    acc
  end

  defp persist(heroes) do
    :persistent_term.put(@key, heroes)
  end
end
