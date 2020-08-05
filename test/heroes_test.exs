defmodule Telescope.HeroesTest do
  use ExUnit.Case

  alias Telescope.Heroes

  setup do
    :ok = Heroes.load()
  end

  describe "Heroes.name/1" do
    test "Returns the hero name if there is one" do
      :telescope
      |> :code.priv_dir()
      |> Path.join("heroes.json")
      |> File.read!()
      |> Jason.decode!()
      |> Enum.each(fn %{"id" => id, "localized_name" => name} ->
        assert Heroes.name(id) == name
      end)
    end

    test "Returns 'Unknown' if there is no hero" do
      assert Heroes.name(-1) == "Unknown"
    end
  end
end
