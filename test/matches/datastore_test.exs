defmodule Telescope.Matches.DatastoreTest do
  use Telescope.DataCase

  alias Telescope.Matches.{Datastore, Match, MatchPlayer, SeqNum}
  alias Telescope.Repo

  import Telescope.Factory
  import Telescope.Fixtures

  describe "Datastore.write_match/1" do
    test "it persists a matches with pro players" do
      Enum.each([match1(), match3()], fn fixture ->
        {:ok, match} =
          fixture
          |> Match.parse()
          |> Datastore.write_match()

        assert match ==
                 Match
                 |> Ecto.Query.preload([:radiant_players, :dire_players])
                 |> Repo.get!(match.id)
      end)
    end

    test "it does not persist a match with no pro players" do
      assert {:error,
              %Ecto.Changeset{
                data: %Match{},
                valid?: false
              }} =
               match2()
               |> Match.parse()
               |> Datastore.write_match()
    end

    test "it persists pro match players" do
      assert {:ok, %Match{radiant_players: [kuro]}} =
               match1()
               |> Match.parse()
               |> Datastore.write_match()

      assert kuro == Repo.get_by!(MatchPlayer, name: "KuroKy")

      assert {:ok, %Match{dire_players: [jerax]}} =
               match3()
               |> Match.parse()
               |> Datastore.write_match()

      assert jerax == Repo.get_by!(MatchPlayer, name: "JerAx")
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

  describe "Datastore.write_match_seq_num/1" do
    test "it writes the larger match seq num" do
      assert Repo.all(SeqNum) == []

      Datastore.write_match_seq_num(5_000_000_000)

      assert Datastore.get_match_seq_num() == 5_000_000_000
    end

    test "it updates the match seq num if there is one already" do
      Datastore.write_match_seq_num(5_000_000_000)
      Datastore.write_match_seq_num(5_000_000_001)

      assert Datastore.get_match_seq_num() == 5_000_000_001
    end
  end
end
