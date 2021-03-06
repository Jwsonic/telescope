defmodule Telescope.Fixtures do
  @moduledoc """
  Fixtures loads real match data from json files into maps
  for use in tests.
  """
  @fixture_path Path.join(__DIR__, "fixtures")

  @spec match1 :: map()
  def match1, do: load("match1.json")

  @spec match2 :: map()
  def match2, do: load("match2.json")

  @spec match3 :: map()
  def match3, do: load("match3.json")

  @spec match4 :: map()
  def match4, do: load("match4.json")

  defp load(filename) do
    @fixture_path
    |> Path.join(filename)
    |> File.read!()
    |> Jason.decode!()
  end
end
