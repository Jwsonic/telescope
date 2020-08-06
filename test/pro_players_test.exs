defmodule Telescope.ProPlayersTest do
  use ExUnit.Case

  alias Telescope.ProPlayers

  describe "ProPlayers.name/1" do
    test "Returns the hero name if there is one" do
      :telescope
      |> :code.priv_dir()
      |> Path.join("pro_players.json")
      |> File.read!()
      |> Jason.decode!()
      |> Enum.each(fn %{"account_id" => id, "name" => name} ->
        assert ProPlayers.name(id) == name
      end)
    end

    test "Returns 'Unknown' if there is no player" do
      assert ProPlayers.name(-1) == "Unknown"
    end
  end
end
