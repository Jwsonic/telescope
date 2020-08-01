defmodule Telescope.Matches.MatchesTest do
  use Telescope.DataCase

  alias Telescope.{Matches, Repo}
  alias Telescope.Matches.SeqNum

  import Telescope.Factory

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
end
