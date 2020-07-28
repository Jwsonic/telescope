defmodule Telescope.Games.GameTest do
  use ExUnit.Case

  alias Telescope.Games.Game

  describe "Game.parse/1" do
    test "it correctly parses real match data" do
      assert game1()
             |> Jason.decode!()
             |> Game.parse() ==
               {:ok,
                %Game{
                  duration: 606,
                  match_id: 5_469_067_607,
                  match_seq_num: 4_583_985_737,
                  radiant_win: true,
                  start_time: ~U[2020-06-13 16:29:18Z]
                }}

      assert game2()
             |> Jason.decode!()
             |> Game.parse() ==
               {:ok,
                %Game{
                  duration: 1829,
                  match_id: 5_469_051_040,
                  match_seq_num: 4_583_985_738,
                  radiant_win: true,
                  start_time: ~U[2020-06-13 16:18:40Z]
                }}
    end

    test "it fails without a valid data" do
      assert {:error, %Ecto.Changeset{valid?: false}} = Game.parse(%{"match_id" => 0})
    end

    test "it fails without players" do
      assert {:error, %Ecto.Changeset{valid?: false}} = Game.parse(%{"match_id" => 0})
    end
  end

  defp game1 do
    ~s(
  {
    "players": [
      {
        "account_id": 1010256661,
        "player_slot": 0,
        "hero_id": 70,
        "item_0": 106,
        "item_1": 11,
        "item_2": 36,
        "item_3": 244,
        "item_4": 181,
        "item_5": 63,
        "backpack_0": 39,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 304,
        "kills": 8,
        "deaths": 0,
        "assists": 0,
        "leaver_status": 0,
        "last_hits": 70,
        "denies": 16,
        "gold_per_min": 546,
        "xp_per_min": 532,
        "level": 9,
        "hero_damage": 6673,
        "tower_damage": 123,
        "hero_healing": 0,
        "gold": 466,
        "gold_spent": 5800,
        "scaled_hero_damage": 9119,
        "scaled_tower_damage": 53,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5359,
            "time": 776,
            "level": 1
          },
          {
            "ability": 5357,
            "time": 932,
            "level": 2
          },
          {
            "ability": 5357,
            "time": 974,
            "level": 3
          },
          {
            "ability": 5359,
            "time": 1046,
            "level": 4
          },
          {
            "ability": 5357,
            "time": 1131,
            "level": 5
          },
          {
            "ability": 5360,
            "time": 1197,
            "level": 6
          },
          {
            "ability": 5357,
            "time": 1257,
            "level": 7
          },
          {
            "ability": 5359,
            "time": 1320,
            "level": 8
          },
          {
            "ability": 5359,
            "time": 1385,
            "level": 9
          }
        ]
      },
      {
        "account_id": 852616094,
        "player_slot": 1,
        "hero_id": 74,
        "item_0": 92,
        "item_1": 77,
        "item_2": 77,
        "item_3": 237,
        "item_4": 265,
        "item_5": 63,
        "backpack_0": 0,
        "backpack_1": 241,
        "backpack_2": 0,
        "item_neutral": 354,
        "kills": 4,
        "deaths": 0,
        "assists": 1,
        "leaver_status": 0,
        "last_hits": 49,
        "denies": 19,
        "gold_per_min": 408,
        "xp_per_min": 515,
        "level": 9,
        "hero_damage": 3779,
        "tower_damage": 928,
        "hero_healing": 0,
        "gold": 1121,
        "gold_spent": 3605,
        "scaled_hero_damage": 4502,
        "scaled_tower_damage": 350,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5370,
            "time": 839,
            "level": 1
          },
          {
            "ability": 5371,
            "time": 894,
            "level": 2
          },
          {
            "ability": 5371,
            "time": 938,
            "level": 3
          },
          {
            "ability": 5370,
            "time": 994,
            "level": 4
          },
          {
            "ability": 5371,
            "time": 1076,
            "level": 5
          },
          {
            "ability": 5370,
            "time": 1129,
            "level": 6
          },
          {
            "ability": 5371,
            "time": 1219,
            "level": 7
          },
          {
            "ability": 5370,
            "time": 1285,
            "level": 8
          },
          {
            "ability": 5371,
            "time": 1340,
            "level": 9
          }
        ]
      },
      {
        "account_id": 431889814,
        "player_slot": 2,
        "hero_id": 9,
        "item_0": 28,
        "item_1": 28,
        "item_2": 17,
        "item_3": 38,
        "item_4": 29,
        "item_5": 0,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 0,
        "deaths": 1,
        "assists": 6,
        "leaver_status": 0,
        "last_hits": 13,
        "denies": 2,
        "gold_per_min": 211,
        "xp_per_min": 204,
        "level": 5,
        "hero_damage": 3734,
        "tower_damage": 287,
        "hero_healing": 400,
        "gold": 787,
        "gold_spent": 2150,
        "scaled_hero_damage": 4263,
        "scaled_tower_damage": 115,
        "scaled_hero_healing": 327,
        "ability_upgrades": [
          {
            "ability": 5048,
            "time": 803,
            "level": 1
          },
          {
            "ability": 5050,
            "time": 972,
            "level": 2
          },
          {
            "ability": 5051,
            "time": 1053,
            "level": 3
          },
          {
            "ability": 5051,
            "time": 1186,
            "level": 4
          },
          {
            "ability": 5051,
            "time": 1329,
            "level": 5
          }
        ]
      },
      {
        "account_id": 431212285,
        "player_slot": 3,
        "hero_id": 90,
        "item_0": 94,
        "item_1": 214,
        "item_2": 43,
        "item_3": 34,
        "item_4": 0,
        "item_5": 0,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 349,
        "kills": 0,
        "deaths": 0,
        "assists": 8,
        "leaver_status": 0,
        "last_hits": 8,
        "denies": 2,
        "gold_per_min": 198,
        "xp_per_min": 232,
        "level": 6,
        "hero_damage": 1872,
        "tower_damage": 167,
        "hero_healing": 0,
        "gold": 464,
        "gold_spent": 2160,
        "scaled_hero_damage": 2275,
        "scaled_tower_damage": 88,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5476,
            "time": 800,
            "level": 1
          },
          {
            "ability": 5473,
            "time": 948,
            "level": 2
          },
          {
            "ability": 5473,
            "time": 1094,
            "level": 3
          },
          {
            "ability": 5471,
            "time": 1224,
            "level": 4
          },
          {
            "ability": 5473,
            "time": 1380,
            "level": 5
          }
        ]
      },
      {
        "account_id": 385538682,
        "player_slot": 4,
        "hero_id": 53,
        "item_0": 63,
        "item_1": 34,
        "item_2": 0,
        "item_3": 16,
        "item_4": 0,
        "item_5": 240,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 3,
        "deaths": 1,
        "assists": 4,
        "leaver_status": 0,
        "last_hits": 57,
        "denies": 8,
        "gold_per_min": 439,
        "xp_per_min": 386,
        "level": 8,
        "hero_damage": 4612,
        "tower_damage": 2652,
        "hero_healing": 0,
        "gold": 2780,
        "gold_spent": 2200,
        "scaled_hero_damage": 4674,
        "scaled_tower_damage": 1257,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5247,
            "time": 744,
            "level": 1
          },
          {
            "ability": 5246,
            "time": 912,
            "level": 2
          },
          {
            "ability": 5247,
            "time": 1074,
            "level": 3
          },
          {
            "ability": 5245,
            "time": 1079,
            "level": 4
          },
          {
            "ability": 5247,
            "time": 1172,
            "level": 5
          },
          {
            "ability": 5248,
            "time": 1256,
            "level": 6
          },
          {
            "ability": 5247,
            "time": 1338,
            "level": 7
          },
          {
            "ability": 5246,
            "time": 1432,
            "level": 8
          }
        ]
      },
      {
        "account_id": 389783263,
        "player_slot": 128,
        "hero_id": 75,
        "item_0": 77,
        "item_1": 77,
        "item_2": 29,
        "item_3": 0,
        "item_4": 0,
        "item_5": 0,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 1,
        "deaths": 5,
        "assists": 1,
        "leaver_status": 0,
        "last_hits": 0,
        "denies": 1,
        "gold_per_min": 105,
        "xp_per_min": 124,
        "level": 4,
        "hero_damage": 2864,
        "tower_damage": 0,
        "hero_healing": 0,
        "gold": 22,
        "gold_spent": 2120,
        "scaled_hero_damage": 3073,
        "scaled_tower_damage": 0,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5378,
            "time": 748,
            "level": 1
          },
          {
            "ability": 5379,
            "time": 1014,
            "level": 2
          },
          {
            "ability": 5378,
            "time": 1149,
            "level": 3
          },
          {
            "ability": 5377,
            "time": 1344,
            "level": 4
          }
        ]
      },
      {
        "account_id": 869083207,
        "player_slot": 129,
        "hero_id": 94,
        "item_0": 75,
        "item_1": 75,
        "item_2": 25,
        "item_3": 29,
        "item_4": 0,
        "item_5": 0,
        "backpack_0": 241,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 0,
        "deaths": 4,
        "assists": 0,
        "leaver_status": 0,
        "last_hits": 24,
        "denies": 4,
        "gold_per_min": 169,
        "xp_per_min": 289,
        "level": 6,
        "hero_damage": 2820,
        "tower_damage": 0,
        "hero_healing": 0,
        "gold": 245,
        "gold_spent": 1970,
        "scaled_hero_damage": 1968,
        "scaled_tower_damage": 0,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5505,
            "time": 743,
            "level": 1
          },
          {
            "ability": 5506,
            "time": 894,
            "level": 2
          },
          {
            "ability": 5505,
            "time": 958,
            "level": 3
          },
          {
            "ability": 5504,
            "time": 1027,
            "level": 4
          },
          {
            "ability": 5505,
            "time": 1143,
            "level": 5
          },
          {
            "ability": 5504,
            "time": 1211,
            "level": 6
          }
        ]
      },
      {
        "account_id": 733269898,
        "player_slot": 130,
        "hero_id": 1,
        "item_0": 11,
        "item_1": 56,
        "item_2": 75,
        "item_3": 0,
        "item_4": 0,
        "item_5": 0,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 0,
        "deaths": 2,
        "assists": 1,
        "leaver_status": 0,
        "last_hits": 11,
        "denies": 5,
        "gold_per_min": 131,
        "xp_per_min": 179,
        "level": 5,
        "hero_damage": 634,
        "tower_damage": 0,
        "hero_healing": 0,
        "gold": 280,
        "gold_spent": 1720,
        "scaled_hero_damage": 826,
        "scaled_tower_damage": 0,
        "scaled_hero_healing": 0,
        "ability_upgrades": [
          {
            "ability": 5003,
            "time": 749,
            "level": 1
          },
          {
            "ability": 5004,
            "time": 929,
            "level": 2
          },
          {
            "ability": 5003,
            "time": 1051,
            "level": 3
          },
          {
            "ability": 7314,
            "time": 1148,
            "level": 4
          },
          {
            "ability": 5003,
            "time": 1343,
            "level": 5
          }
        ]
      },
      {
        "account_id": 453343327,
        "player_slot": 131,
        "hero_id": 84,
        "item_0": 77,
        "item_1": 44,
        "item_2": 216,
        "item_3": 29,
        "item_4": 0,
        "item_5": 0,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 1,
        "deaths": 0,
        "assists": 1,
        "leaver_status": 0,
        "last_hits": 10,
        "denies": 2,
        "gold_per_min": 132,
        "xp_per_min": 174,
        "level": 5,
        "hero_damage": 1816,
        "tower_damage": 0,
        "hero_healing": 400,
        "gold": 247,
        "gold_spent": 1850,
        "scaled_hero_damage": 2310,
        "scaled_tower_damage": 0,
        "scaled_hero_healing": 286,
        "ability_upgrades": [
          {
            "ability": 5439,
            "time": 783,
            "level": 1
          },
          {
            "ability": 5438,
            "time": 929,
            "level": 2
          },
          {
            "ability": 5439,
            "time": 1033,
            "level": 3
          },
          {
            "ability": 5440,
            "time": 1159,
            "level": 4
          },
          {
            "ability": 5438,
            "time": 1280,
            "level": 5
          }
        ]
      },
      {
        "account_id": 971788658,
        "player_slot": 132,
        "hero_id": 36,
        "item_0": 77,
        "item_1": 77,
        "item_2": 29,
        "item_3": 0,
        "item_4": 0,
        "item_5": 0,
        "backpack_0": 0,
        "backpack_1": 0,
        "backpack_2": 0,
        "item_neutral": 0,
        "kills": 0,
        "deaths": 5,
        "assists": 0,
        "leaver_status": 1,
        "last_hits": 11,
        "denies": 4,
        "gold_per_min": 130,
        "xp_per_min": 178,
        "level": 5,
        "hero_damage": 1114,
        "tower_damage": 0,
        "hero_healing": 60,
        "gold": 130,
        "gold_spent": 1700,
        "scaled_hero_damage": 943,
        "scaled_tower_damage": 0,
        "scaled_hero_healing": 68,
        "ability_upgrades": [
          {
            "ability": 5159,
            "time": 785,
            "level": 1
          },
          {
            "ability": 5158,
            "time": 1016,
            "level": 2
          },
          {
            "ability": 5160,
            "time": 1163,
            "level": 3
          },
          {
            "ability": 5159,
            "time": 1243,
            "level": 4
          },
          {
            "ability": 5158,
            "time": 1342,
            "level": 5
          }
        ]
      }
    ],
    "radiant_win": true,
    "duration": 606,
    "pre_game_duration": 90,
    "start_time": 1592065758,
    "match_id": 5469067607,
    "match_seq_num": 4583985737,
    "tower_status_radiant": 2047,
    "tower_status_dire": 2044,
    "barracks_status_radiant": 63,
    "barracks_status_dire": 63,
    "cluster": 133,
    "first_blood_time": 18,
    "lobby_type": 1,
    "human_players": 10,
    "leagueid": 12101,
    "positive_votes": 0,
    "negative_votes": 0,
    "game_mode": 2,
    "flags": 1,
    "engine": 1,
    "radiant_score": 16,
    "dire_score": 2,
    "radiant_team_id": 8022788,
    "radiant_name": "albedo",
    "radiant_logo": 1187209343573389378,
    "radiant_team_complete": 1,
    "dire_team_id": 8022855,
    "dire_name": "RainBow Team",
    "dire_logo": 1174824798819286285,
    "dire_team_complete": 1,
    "radiant_captain": 1010256661,
    "dire_captain": 869083207,
    "picks_bans": [
      {
        "is_pick": false,
        "hero_id": 31,
        "team": 0,
        "order": 0
      },
      {
        "is_pick": false,
        "hero_id": 82,
        "team": 1,
        "order": 1
      },
      {
        "is_pick": false,
        "hero_id": 56,
        "team": 0,
        "order": 2
      },
      {
        "is_pick": false,
        "hero_id": 17,
        "team": 1,
        "order": 3
      },
      {
        "is_pick": false,
        "hero_id": 64,
        "team": 0,
        "order": 4
      },
      {
        "is_pick": false,
        "hero_id": 52,
        "team": 1,
        "order": 5
      },
      {
        "is_pick": false,
        "hero_id": 47,
        "team": 0,
        "order": 6
      },
      {
        "is_pick": false,
        "hero_id": 99,
        "team": 1,
        "order": 7
      },
      {
        "is_pick": true,
        "hero_id": 90,
        "team": 0,
        "order": 8
      },
      {
        "is_pick": true,
        "hero_id": 84,
        "team": 1,
        "order": 9
      },
      {
        "is_pick": true,
        "hero_id": 75,
        "team": 1,
        "order": 10
      },
      {
        "is_pick": true,
        "hero_id": 70,
        "team": 0,
        "order": 11
      },
      {
        "is_pick": false,
        "hero_id": 95,
        "team": 0,
        "order": 12
      },
      {
        "is_pick": false,
        "hero_id": 44,
        "team": 1,
        "order": 13
      },
      {
        "is_pick": true,
        "hero_id": 36,
        "team": 1,
        "order": 14
      },
      {
        "is_pick": true,
        "hero_id": 9,
        "team": 0,
        "order": 15
      },
      {
        "is_pick": true,
        "hero_id": 1,
        "team": 1,
        "order": 16
      },
      {
        "is_pick": true,
        "hero_id": 53,
        "team": 0,
        "order": 17
      },
      {
        "is_pick": false,
        "hero_id": 80,
        "team": 1,
        "order": 18
      },
      {
        "is_pick": false,
        "hero_id": 65,
        "team": 0,
        "order": 19
      },
      {
        "is_pick": true,
        "hero_id": 74,
        "team": 0,
        "order": 20
      },
      {
        "is_pick": true,
        "hero_id": 94,
        "team": 1,
        "order": 21
      }
    ]
  }
  )
  end

  defp game2 do
    ~s({
      "players": [
        {
          "account_id": 177811752,
          "player_slot": 0,
          "hero_id": 11,
          "item_0": 152,
          "item_1": 63,
          "item_2": 208,
          "item_3": 16,
          "item_4": 41,
          "item_5": 0,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 357,
          "kills": 12,
          "deaths": 3,
          "assists": 12,
          "leaver_status": 0,
          "last_hits": 199,
          "denies": 25,
          "gold_per_min": 533,
          "xp_per_min": 709,
          "level": 22,
          "hero_damage": 19308,
          "tower_damage": 5497,
          "hero_healing": 0,
          "gold": 3572,
          "gold_spent": 12860,
          "scaled_hero_damage": 15279,
          "scaled_tower_damage": 2409,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5062,
              "time": 264,
              "level": 1
            },
            {
              "ability": 5061,
              "time": 293,
              "level": 2
            },
            {
              "ability": 5060,
              "time": 351,
              "level": 3
            },
            {
              "ability": 5062,
              "time": 393,
              "level": 4
            },
            {
              "ability": 5061,
              "time": 459,
              "level": 5
            },
            {
              "ability": 5064,
              "time": 536,
              "level": 6
            },
            {
              "ability": 5059,
              "time": 627,
              "level": 7
            },
            {
              "ability": 5062,
              "time": 704,
              "level": 8
            },
            {
              "ability": 5062,
              "time": 755,
              "level": 9
            },
            {
              "ability": 5996,
              "time": 878,
              "level": 10
            },
            {
              "ability": 5063,
              "time": 992,
              "level": 11
            },
            {
              "ability": 5064,
              "time": 1129,
              "level": 12
            },
            {
              "ability": 5063,
              "time": 1252,
              "level": 13
            },
            {
              "ability": 5063,
              "time": 1343,
              "level": 14
            },
            {
              "ability": 6875,
              "time": 1443,
              "level": 15
            },
            {
              "ability": 5063,
              "time": 1552,
              "level": 16
            },
            {
              "ability": 5064,
              "time": 1660,
              "level": 17
            },
            {
              "ability": 6070,
              "time": 1941,
              "level": 18
            }
          ]
        },
        {
          "account_id": 139610394,
          "player_slot": 1,
          "hero_id": 75,
          "item_0": 236,
          "item_1": 206,
          "item_2": 36,
          "item_3": 216,
          "item_4": 77,
          "item_5": 63,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 331,
          "kills": 13,
          "deaths": 3,
          "assists": 16,
          "leaver_status": 0,
          "last_hits": 35,
          "denies": 0,
          "gold_per_min": 312,
          "xp_per_min": 466,
          "level": 17,
          "hero_damage": 17090,
          "tower_damage": 3295,
          "hero_healing": 0,
          "gold": 1605,
          "gold_spent": 8345,
          "scaled_hero_damage": 12533,
          "scaled_tower_damage": 1549,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5378,
              "time": 179,
              "level": 1
            },
            {
              "ability": 5377,
              "time": 344,
              "level": 2
            },
            {
              "ability": 5378,
              "time": 440,
              "level": 3
            },
            {
              "ability": 5379,
              "time": 606,
              "level": 4
            },
            {
              "ability": 5378,
              "time": 775,
              "level": 5
            },
            {
              "ability": 5380,
              "time": 869,
              "level": 6
            },
            {
              "ability": 5378,
              "time": 1036,
              "level": 7
            },
            {
              "ability": 5379,
              "time": 1108,
              "level": 8
            },
            {
              "ability": 5377,
              "time": 1399,
              "level": 9
            },
            {
              "ability": 5906,
              "time": 1439,
              "level": 10
            },
            {
              "ability": 5377,
              "time": 1472,
              "level": 11
            },
            {
              "ability": 5380,
              "time": 1640,
              "level": 12
            },
            {
              "ability": 5377,
              "time": 1736,
              "level": 13
            },
            {
              "ability": 5379,
              "time": 1883,
              "level": 14
            },
            {
              "ability": 6878,
              "time": 1995,
              "level": 15
            },
            {
              "ability": 5379,
              "time": 2008,
              "level": 16
            }
          ]
        },
        {
          "account_id": 4294967295,
          "player_slot": 2,
          "hero_id": 44,
          "item_0": 29,
          "item_1": 36,
          "item_2": 168,
          "item_3": 116,
          "item_4": 117,
          "item_5": 145,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 376,
          "kills": 11,
          "deaths": 1,
          "assists": 11,
          "leaver_status": 0,
          "last_hits": 197,
          "denies": 5,
          "gold_per_min": 515,
          "xp_per_min": 710,
          "level": 22,
          "hero_damage": 26655,
          "tower_damage": 3493,
          "hero_healing": 0,
          "gold": 3002,
          "gold_spent": 12990,
          "scaled_hero_damage": 14921,
          "scaled_tower_damage": 1742,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5190,
              "time": 190,
              "level": 1
            },
            {
              "ability": 5191,
              "time": 334,
              "level": 2
            },
            {
              "ability": 5190,
              "time": 404,
              "level": 3
            },
            {
              "ability": 5191,
              "time": 489,
              "level": 4
            },
            {
              "ability": 5192,
              "time": 664,
              "level": 5
            },
            {
              "ability": 5193,
              "time": 756,
              "level": 6
            },
            {
              "ability": 5190,
              "time": 839,
              "level": 7
            },
            {
              "ability": 5190,
              "time": 949,
              "level": 8
            },
            {
              "ability": 5191,
              "time": 1057,
              "level": 9
            },
            {
              "ability": 6159,
              "time": 1185,
              "level": 10
            },
            {
              "ability": 5191,
              "time": 1251,
              "level": 11
            },
            {
              "ability": 5193,
              "time": 1318,
              "level": 12
            },
            {
              "ability": 5192,
              "time": 1385,
              "level": 13
            },
            {
              "ability": 6801,
              "time": 1491,
              "level": 14
            },
            {
              "ability": 5192,
              "time": 1504,
              "level": 15
            },
            {
              "ability": 5192,
              "time": 1606,
              "level": 16
            },
            {
              "ability": 5193,
              "time": 1748,
              "level": 17
            },
            {
              "ability": 6848,
              "time": 1981,
              "level": 18
            }
          ]
        },
        {
          "account_id": 4294967295,
          "player_slot": 3,
          "hero_id": 86,
          "item_0": 267,
          "item_1": 214,
          "item_2": 232,
          "item_3": 218,
          "item_4": 240,
          "item_5": 16,
          "backpack_0": 16,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 290,
          "kills": 3,
          "deaths": 2,
          "assists": 20,
          "leaver_status": 0,
          "last_hits": 33,
          "denies": 5,
          "gold_per_min": 282,
          "xp_per_min": 404,
          "level": 15,
          "hero_damage": 10695,
          "tower_damage": 0,
          "hero_healing": 0,
          "gold": 1222,
          "gold_spent": 8000,
          "scaled_hero_damage": 7660,
          "scaled_tower_damage": 0,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5450,
              "time": 222,
              "level": 1
            },
            {
              "ability": 5448,
              "time": 313,
              "level": 2
            },
            {
              "ability": 5450,
              "time": 438,
              "level": 3
            },
            {
              "ability": 5448,
              "time": 541,
              "level": 4
            },
            {
              "ability": 5450,
              "time": 741,
              "level": 5
            },
            {
              "ability": 5452,
              "time": 844,
              "level": 6
            },
            {
              "ability": 5450,
              "time": 997,
              "level": 7
            },
            {
              "ability": 5448,
              "time": 1203,
              "level": 8
            },
            {
              "ability": 5448,
              "time": 1285,
              "level": 9
            },
            {
              "ability": 5941,
              "time": 1412,
              "level": 10
            },
            {
              "ability": 7320,
              "time": 1475,
              "level": 11
            },
            {
              "ability": 7320,
              "time": 1694,
              "level": 12
            },
            {
              "ability": 7320,
              "time": 1781,
              "level": 13
            },
            {
              "ability": 7320,
              "time": 1964,
              "level": 14
            },
            {
              "ability": 5452,
              "time": 2038,
              "level": 15
            }
          ]
        },
        {
          "account_id": 145449498,
          "player_slot": 4,
          "hero_id": 38,
          "item_0": 29,
          "item_1": 194,
          "item_2": 16,
          "item_3": 11,
          "item_4": 164,
          "item_5": 81,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 360,
          "kills": 1,
          "deaths": 3,
          "assists": 23,
          "leaver_status": 0,
          "last_hits": 138,
          "denies": 12,
          "gold_per_min": 400,
          "xp_per_min": 527,
          "level": 18,
          "hero_damage": 14450,
          "tower_damage": 3164,
          "hero_healing": 3671,
          "gold": 2305,
          "gold_spent": 10235,
          "scaled_hero_damage": 9288,
          "scaled_tower_damage": 1549,
          "scaled_hero_healing": 1540,
          "ability_upgrades": [
            {
              "ability": 7230,
              "time": 165,
              "level": 1
            },
            {
              "ability": 5172,
              "time": 328,
              "level": 2
            },
            {
              "ability": 7230,
              "time": 440,
              "level": 3
            },
            {
              "ability": 5172,
              "time": 538,
              "level": 4
            },
            {
              "ability": 7230,
              "time": 654,
              "level": 5
            },
            {
              "ability": 5177,
              "time": 811,
              "level": 6
            },
            {
              "ability": 7230,
              "time": 866,
              "level": 7
            },
            {
              "ability": 5172,
              "time": 977,
              "level": 8
            },
            {
              "ability": 5172,
              "time": 1096,
              "level": 9
            },
            {
              "ability": 6009,
              "time": 1216,
              "level": 10
            },
            {
              "ability": 5168,
              "time": 1317,
              "level": 11
            },
            {
              "ability": 5177,
              "time": 1426,
              "level": 12
            },
            {
              "ability": 5168,
              "time": 1481,
              "level": 13
            },
            {
              "ability": 5168,
              "time": 1525,
              "level": 14
            },
            {
              "ability": 5933,
              "time": 1665,
              "level": 15
            },
            {
              "ability": 5168,
              "time": 1780,
              "level": 16
            },
            {
              "ability": 5177,
              "time": 2007,
              "level": 17
            }
          ]
        },
        {
          "account_id": 126250358,
          "player_slot": 128,
          "hero_id": 73,
          "item_0": 11,
          "item_1": 116,
          "item_2": 9,
          "item_3": 50,
          "item_4": 178,
          "item_5": 137,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 359,
          "kills": 2,
          "deaths": 5,
          "assists": 5,
          "leaver_status": 0,
          "last_hits": 183,
          "denies": 3,
          "gold_per_min": 506,
          "xp_per_min": 507,
          "level": 18,
          "hero_damage": 7142,
          "tower_damage": 66,
          "hero_healing": 0,
          "gold": 1233,
          "gold_spent": 13815,
          "scaled_hero_damage": 4247,
          "scaled_tower_damage": 54,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5368,
              "time": 233,
              "level": 1
            },
            {
              "ability": 5365,
              "time": 317,
              "level": 2
            },
            {
              "ability": 5365,
              "time": 373,
              "level": 3
            },
            {
              "ability": 5366,
              "time": 483,
              "level": 4
            },
            {
              "ability": 5365,
              "time": 558,
              "level": 5
            },
            {
              "ability": 5369,
              "time": 640,
              "level": 6
            },
            {
              "ability": 5365,
              "time": 758,
              "level": 7
            },
            {
              "ability": 5368,
              "time": 838,
              "level": 8
            },
            {
              "ability": 5368,
              "time": 1002,
              "level": 9
            },
            {
              "ability": 6119,
              "time": 1091,
              "level": 10
            },
            {
              "ability": 5368,
              "time": 1147,
              "level": 11
            },
            {
              "ability": 5369,
              "time": 1240,
              "level": 12
            },
            {
              "ability": 5366,
              "time": 1380,
              "level": 13
            },
            {
              "ability": 5366,
              "time": 1541,
              "level": 14
            },
            {
              "ability": 6195,
              "time": 1662,
              "level": 15
            },
            {
              "ability": 5366,
              "time": 1862,
              "level": 16
            },
            {
              "ability": 5369,
              "time": 2042,
              "level": 17
            }
          ]
        },
        {
          "account_id": 881272745,
          "player_slot": 129,
          "hero_id": 7,
          "item_0": 29,
          "item_1": 36,
          "item_2": 40,
          "item_3": 1,
          "item_4": 73,
          "item_5": 0,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 289,
          "kills": 1,
          "deaths": 10,
          "assists": 5,
          "leaver_status": 0,
          "last_hits": 61,
          "denies": 2,
          "gold_per_min": 219,
          "xp_per_min": 323,
          "level": 14,
          "hero_damage": 11196,
          "tower_damage": 0,
          "hero_healing": 0,
          "gold": 859,
          "gold_spent": 5320,
          "scaled_hero_damage": 6597,
          "scaled_tower_damage": 0,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5023,
              "time": 188,
              "level": 1
            },
            {
              "ability": 5025,
              "time": 373,
              "level": 2
            },
            {
              "ability": 5024,
              "time": 534,
              "level": 3
            },
            {
              "ability": 5023,
              "time": 700,
              "level": 4
            },
            {
              "ability": 5025,
              "time": 828,
              "level": 5
            },
            {
              "ability": 5026,
              "time": 891,
              "level": 6
            },
            {
              "ability": 5025,
              "time": 1008,
              "level": 7
            },
            {
              "ability": 5024,
              "time": 1279,
              "level": 8
            },
            {
              "ability": 5025,
              "time": 1468,
              "level": 9
            },
            {
              "ability": 6094,
              "time": 1557,
              "level": 10
            },
            {
              "ability": 5023,
              "time": 1716,
              "level": 11
            },
            {
              "ability": 5026,
              "time": 1854,
              "level": 12
            },
            {
              "ability": 5023,
              "time": 1991,
              "level": 13
            },
            {
              "ability": 5024,
              "time": 2039,
              "level": 14
            }
          ]
        },
        {
          "account_id": 4294967295,
          "player_slot": 130,
          "hero_id": 14,
          "item_0": 214,
          "item_1": 206,
          "item_2": 13,
          "item_3": 43,
          "item_4": 0,
          "item_5": 0,
          "backpack_0": 0,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 306,
          "kills": 2,
          "deaths": 10,
          "assists": 6,
          "leaver_status": 0,
          "last_hits": 22,
          "denies": 0,
          "gold_per_min": 175,
          "xp_per_min": 298,
          "level": 13,
          "hero_damage": 7139,
          "tower_damage": 0,
          "hero_healing": 0,
          "gold": 541,
          "gold_spent": 4965,
          "scaled_hero_damage": 4871,
          "scaled_tower_damage": 0,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5075,
              "time": 224,
              "level": 1
            },
            {
              "ability": 5076,
              "time": 359,
              "level": 2
            },
            {
              "ability": 5075,
              "time": 495,
              "level": 3
            },
            {
              "ability": 5076,
              "time": 662,
              "level": 4
            },
            {
              "ability": 5077,
              "time": 839,
              "level": 5
            },
            {
              "ability": 5075,
              "time": 839,
              "level": 6
            },
            {
              "ability": 5075,
              "time": 1246,
              "level": 7
            },
            {
              "ability": 5076,
              "time": 1442,
              "level": 8
            },
            {
              "ability": 5074,
              "time": 1518,
              "level": 9
            },
            {
              "ability": 6245,
              "time": 1578,
              "level": 10
            },
            {
              "ability": 5077,
              "time": 1749,
              "level": 11
            },
            {
              "ability": 5076,
              "time": 1752,
              "level": 12
            },
            {
              "ability": 5074,
              "time": 2039,
              "level": 13
            }
          ]
        },
        {
          "account_id": 4294967295,
          "player_slot": 131,
          "hero_id": 26,
          "item_0": 36,
          "item_1": 43,
          "item_2": 214,
          "item_3": 39,
          "item_4": 0,
          "item_5": 1,
          "backpack_0": 336,
          "backpack_1": 0,
          "backpack_2": 0,
          "item_neutral": 349,
          "kills": 0,
          "deaths": 4,
          "assists": 5,
          "leaver_status": 0,
          "last_hits": 62,
          "denies": 19,
          "gold_per_min": 208,
          "xp_per_min": 382,
          "level": 15,
          "hero_damage": 5088,
          "tower_damage": 0,
          "hero_healing": 0,
          "gold": 1024,
          "gold_spent": 4980,
          "scaled_hero_damage": 3244,
          "scaled_tower_damage": 0,
          "scaled_hero_healing": 0,
          "ability_upgrades": [
            {
              "ability": 5044,
              "time": 153,
              "level": 1
            },
            {
              "ability": 5045,
              "time": 348,
              "level": 2
            },
            {
              "ability": 5045,
              "time": 395,
              "level": 3
            },
            {
              "ability": 5044,
              "time": 531,
              "level": 4
            },
            {
              "ability": 5045,
              "time": 649,
              "level": 5
            },
            {
              "ability": 5047,
              "time": 745,
              "level": 6
            },
            {
              "ability": 5044,
              "time": 839,
              "level": 7
            },
            {
              "ability": 5044,
              "time": 933,
              "level": 8
            },
            {
              "ability": 5045,
              "time": 1067,
              "level": 9
            },
            {
              "ability": 5947,
              "time": 1267,
              "level": 10
            },
            {
              "ability": 5046,
              "time": 1443,
              "level": 11
            },
            {
              "ability": 5047,
              "time": 1543,
              "level": 12
            },
            {
              "ability": 5046,
              "time": 1611,
              "level": 13
            },
            {
              "ability": 5046,
              "time": 1745,
              "level": 14
            },
            {
              "ability": 465,
              "time": 1949,
              "level": 15
            }
          ]
        },
        {
          "account_id": 4294967295,
          "player_slot": 132,
          "hero_id": 4,
          "item_0": 75,
          "item_1": 36,
          "item_2": 154,
          "item_3": 63,
          "item_4": 75,
          "item_5": 0,
          "backpack_0": 0,
          "backpack_1": 331,
          "backpack_2": 0,
          "item_neutral": 356,
          "kills": 6,
          "deaths": 11,
          "assists": 5,
          "leaver_status": 0,
          "last_hits": 112,
          "denies": 9,
          "gold_per_min": 322,
          "xp_per_min": 504,
          "level": 18,
          "hero_damage": 10037,
          "tower_damage": 0,
          "hero_healing": 205,
          "gold": 457,
          "gold_spent": 7980,
          "scaled_hero_damage": 6794,
          "scaled_tower_damage": 0,
          "scaled_hero_healing": 148,
          "ability_upgrades": [
            {
              "ability": 5016,
              "time": 234,
              "level": 1
            },
            {
              "ability": 5015,
              "time": 311,
              "level": 2
            },
            {
              "ability": 5016,
              "time": 355,
              "level": 3
            },
            {
              "ability": 5017,
              "time": 448,
              "level": 4
            },
            {
              "ability": 5016,
              "time": 535,
              "level": 5
            },
            {
              "ability": 5018,
              "time": 601,
              "level": 6
            },
            {
              "ability": 5015,
              "time": 694,
              "level": 7
            },
            {
              "ability": 5017,
              "time": 815,
              "level": 8
            },
            {
              "ability": 5015,
              "time": 947,
              "level": 9
            },
            {
              "ability": 5906,
              "time": 1135,
              "level": 10
            },
            {
              "ability": 5015,
              "time": 1183,
              "level": 11
            },
            {
              "ability": 5018,
              "time": 1323,
              "level": 12
            },
            {
              "ability": 5017,
              "time": 1474,
              "level": 13
            },
            {
              "ability": 5016,
              "time": 1515,
              "level": 14
            },
            {
              "ability": 6356,
              "time": 1572,
              "level": 15
            },
            {
              "ability": 5017,
              "time": 1670,
              "level": 16
            },
            {
              "ability": 5018,
              "time": 2056,
              "level": 17
            }
          ]
        }
      ],
      "radiant_win": true,
      "duration": 1829,
      "pre_game_duration": 90,
      "start_time": 1592065120,
      "match_id": 5469051040,
      "match_seq_num": 4583985738,
      "tower_status_radiant": 2047,
      "tower_status_dire": 390,
      "barracks_status_radiant": 63,
      "barracks_status_dire": 51,
      "cluster": 227,
      "first_blood_time": 71,
      "lobby_type": 7,
      "human_players": 10,
      "leagueid": 0,
      "positive_votes": 0,
      "negative_votes": 0,
      "game_mode": 3,
      "flags": 1,
      "engine": 1,
      "radiant_score": 40,
      "dire_score": 12,
      "picks_bans": [
        {
          "is_pick": true,
          "hero_id": 64,
          "team": 0,
          "order": 0
        },
        {
          "is_pick": true,
          "hero_id": 7,
          "team": 1,
          "order": 1
        },
        {
          "is_pick": true,
          "hero_id": 86,
          "team": 0,
          "order": 2
        },
        {
          "is_pick": true,
          "hero_id": 75,
          "team": 0,
          "order": 3
        },
        {
          "is_pick": true,
          "hero_id": 14,
          "team": 1,
          "order": 4
        },
        {
          "is_pick": true,
          "hero_id": 73,
          "team": 1,
          "order": 5
        },
        {
          "is_pick": true,
          "hero_id": 38,
          "team": 0,
          "order": 6
        },
        {
          "is_pick": true,
          "hero_id": 26,
          "team": 1,
          "order": 7
        },
        {
          "is_pick": true,
          "hero_id": 44,
          "team": 0,
          "order": 8
        },
        {
          "is_pick": true,
          "hero_id": 4,
          "team": 1,
          "order": 9
        },
        {
          "is_pick": true,
          "hero_id": 11,
          "team": 0,
          "order": 10
        }
      ]
    })
  end
end
