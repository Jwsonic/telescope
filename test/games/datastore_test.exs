defmodule Telescope.Games.DatastoreTest do
  use Telescope.DataCase

  alias Telescope.Games.{Datastore, Game}
  alias Telescope.Repo

  import Telescope.Factory

  describe "Datastore.write_game/1" do
    test "it persists a valid game" do
      {:ok, game} =
        %{
          "duration" => 600,
          "match_id" => 1,
          "match_seq_num" => 1,
          "radiant_win" => true,
          "start_time" => DateTime.utc_now() |> DateTime.to_iso8601()
        }
        |> Game.parse()
        |> Datastore.write_game()

      assert game == Repo.one!(Game)
    end
  end

  describe "Datastore.current_match_seq_num/0" do
    test "it returns the largest match_seq_num" do
      match_seq_num =
        0..10
        |> Enum.map(fn _ -> insert(:game) end)
        |> Enum.map(&Map.get(&1, :match_seq_num))
        |> Enum.reduce(&max/2)

      assert match_seq_num == Datastore.current_match_seq_num()
    end

    test "it has a default" do
      refute Datastore.current_match_seq_num() |> is_nil()
    end
  end
end
