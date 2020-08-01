defmodule Telescope.ValveTest do
  use ExUnit.Case, async: false

  alias Telescope.{Config, Valve}

  setup do
    bypass = Bypass.open()

    Config.put_valve_base_url("http://localhost:#{bypass.port}/")

    on_exit(&Config.reload_valve_base_url/0)

    {:ok, bypass: bypass}
  end

  describe "Valve.match_history/1" do
    test "it makes a correct request to the given base_url", %{bypass: bypass} do
      seq_num = 1
      expected_matches = [%{"id" => 123}]

      Bypass.expect(bypass, fn conn ->
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

      assert Valve.match_history(seq_num) == {:ok, expected_matches}
    end

    @tag :external
    test "it makes a correct request to the real valve API"
  end
end
