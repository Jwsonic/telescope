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
    test "it returns the match_seq_num" do
      match_seq_num = :seq_num |> insert() |> Map.get(:match_seq_num)

      assert match_seq_num == Datastore.get_match_seq_num()
    end

    test "it has a default" do
      refute Datastore.get_match_seq_num() |> is_nil()
    end
  end
end
