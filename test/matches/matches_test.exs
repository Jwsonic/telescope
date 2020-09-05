defmodule Telescope.Matches.MatchesTest do
  use Telescope.DataCase

  alias Telescope.{Matches, Repo}
  alias Telescope.Matches.{Match, SeqNum}

  import Telescope.Factory
  import Telescope.Fixtures

  describe "Matches.get_match_seq_num/0" do
    test "it returns the match_seq_num" do
      match_seq_num = :seq_num |> insert() |> Map.get(:match_seq_num)

      assert Matches.get_match_seq_num() == match_seq_num
    end

    test "it returns a default" do
      assert Repo.all(SeqNum) == []

      assert Matches.get_match_seq_num() |> is_integer()
    end
  end

  describe "Matches.process/1" do
    test "it stores and broadcasts matches with pro players" do
      Matches.subscribe()

      [match1(), match2(), match3(), match4()] |> Matches.process()

      match_id = Map.get(match1(), "match_id")
      assert %Match{match_id: ^match_id} = Repo.get_by!(Match, match_id: match_id)

      assert_receive %Match{match_id: ^match_id}

      match_id = Map.get(match3(), "match_id")
      assert %Match{match_id: ^match_id} = Repo.get_by!(Match, match_id: match_id)

      assert_receive %Match{match_id: ^match_id}

      match_id = Map.get(match4(), "match_id")
      assert %Match{match_id: ^match_id} = Repo.get_by!(Match, match_id: match_id)

      assert_receive %Match{match_id: ^match_id}
    end
  end
end
