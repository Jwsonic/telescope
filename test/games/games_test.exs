defmodule Telescope.Games.GamesTest do
  use Telescope.DataCase

  alias Telescope.{Games, Repo}
  alias Telescope.Games.SeqNum

  import Telescope.Factory

  describe "Games.get_match_seq_num/0" do
    test "it returns the match_seq_num" do
      match_seq_num = :seq_num |> insert() |> Map.get(:match_seq_num)

      assert Games.get_match_seq_num() == match_seq_num
    end

    test "it returns a default" do
      assert Repo.all(SeqNum) == []

      assert Games.get_match_seq_num() |> is_integer()
    end
  end
end
