defmodule Telescope.Fixtures do
  @fixture_path Path.join(__DIR__, "fixtures")

  @spec match1 :: map()
  def match1, do: load("match1.json")

  @spec match2 :: map()
  def match2, do: load("match2.json")

  @spec match3 :: map()
  def match3, do: load("match3.json")

  defp load(filename) do
    @fixture_path
    |> Path.join(filename)
    |> File.read!()
    |> Jason.decode!()
  end
end
