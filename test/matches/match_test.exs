defmodule Telescope.Matches.MatchTest do
  use ExUnit.Case

  alias Ecto.Changeset
  alias Telescope.Matches.{Match, MatchPlayer}

  import Telescope.Fixtures

  describe "Match.parse/1" do
    test "it correctly parses real match data" do
      assert %Match{
               duration: 606,
               match_id: 5_469_067_607,
               match_seq_num: 4_583_985_737,
               radiant_win: true,
               start_time: ~U[2020-06-13 16:29:18Z],
               dire_players: [],
               radiant_players: [
                 %MatchPlayer{
                   hero: "Ursa",
                   name: "KuroKy",
                   radiant?: true
                 }
               ]
             } =
               match1()
               |> Match.parse()
               |> Changeset.apply_action!(:insert)

      assert {:error, %Changeset{data: %Match{}, valid?: false}} =
               match2()
               |> Match.parse()
               |> Changeset.apply_action(:insert)

      assert %Match{
               duration: 2489,
               match_id: 5_535_412_200,
               match_seq_num: 4_643_456_890,
               radiant_win: false,
               start_time: ~U[2020-07-25 16:09:53Z],
               dire_players: [
                 %MatchPlayer{
                   hero: "Doom",
                   name: "JerAx",
                   radiant?: false
                 }
               ],
               radiant_players: []
             } =
               match3()
               |> Match.parse()
               |> Changeset.apply_action!(:insert)
    end

    test "it fails without a valid data" do
      assert %Changeset{data: %Match{}, valid?: false} = Match.parse(%{"match_id" => 0})
    end

    test "it fails without players" do
      assert %Changeset{data: %Match{}, valid?: false} = Match.parse(match2())
    end
  end
end
