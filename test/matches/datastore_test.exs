defmodule Telescope.Matches.DatastoreTest do
  use Telescope.DataCase

  alias Telescope.Matches.{Datastore, Match}
  alias Telescope.Repo

  import Telescope.Factory

  describe "Datastore.write_match/1" do
    test "it persists a valid match" do
      {:ok, match} =
        %{
          "duration" => 600,
          "match_id" => 1,
          "match_seq_num" => 1,
          "radiant_win" => true,
          "start_time" => DateTime.utc_now() |> DateTime.to_iso8601()
        }
        |> Match.parse()
        |> Datastore.write_match()

      assert match == Repo.one!(Match)
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
