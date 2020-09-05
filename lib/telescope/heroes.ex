defmodule Telescope.Heroes do
  @moduledoc """
  Heroes domain API.
  """
  require Logger

  @key __MODULE__
  @hero_file "heroes.json"

  @doc """
  Gets a hero name by id. Returns "Unknown" if there is no hero with the given id.

  You must call `Telescope.Heroes.load/1` before using this method for the first time.
  """
  @spec name(id :: integer()) :: String.t()
  def name(id) when is_integer(id) do
    @key
    |> :persistent_term.get()
    |> Map.get(id, "Unknown")
  end

  @doc """
  Loads Hero information into memory.
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

  defp transform(%{"id" => id, "localized_name" => name}, acc) do
    Map.put(acc, id, name)
  end

  defp transform(hero, acc) do
    Logger.error("Invalid hero: #{inspect(hero)}")

    acc
  end

  defp persist(heroes) do
    :persistent_term.put(@key, heroes)
  end
end
