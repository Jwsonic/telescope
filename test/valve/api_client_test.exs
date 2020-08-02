defmodule Telescope.Valve.ApiClientTest do
  use ExUnit.Case, async: false

  alias Telescope.Config
  alias Telescope.Matches
  alias Telescope.Valve.ApiClient

  describe "ApiClient.match_history/1" do
    test "it makes a correct request to the given base_url" do
      bypass = Bypass.open()

      Config.put_valve_base_url("http://localhost:#{bypass.port}/")

      on_exit(&Config.reload_valve_base_url/0)

      seq_num = 1
      expected_matches = [%{"id" => 123}]

      Bypass.expect_once(bypass, fn conn ->
        assert "GET" == conn.method
        assert "/GetMatchHistoryBySequenceNum/v0001/" == conn.request_path

        assert String.contains?(conn.query_string, "start_at_match_seq_num=#{seq_num}")
        assert String.contains?(conn.query_string, "key=#{Config.valve_api_key!()}")

        response =
          Jason.encode!(%{
            result: %{
              matches: expected_matches
            }
          })

        Plug.Conn.resp(conn, 200, response)
      end)

      assert ApiClient.match_history(seq_num) == {:ok, expected_matches}
    end

    @tag :external
    test "it makes a correct request to the real valve API" do
      {:ok, matches} = ApiClient.match_history(4_643_456_885)

      assert matches
             |> Enum.map(&Matches.Match.parse/1)
             |> Enum.map(&Ecto.Changeset.apply_action(&1, :insert))
             |> Enum.group_by(&elem(&1, 0))
             |> Map.get(:error, 0) == 0
    end
  end
end
