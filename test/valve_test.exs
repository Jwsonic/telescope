defmodule Telescope.ValveTest do
  use ExUnit.Case

  alias Telescope.Valve

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "Valve.match_history/3" do
    test "it makes a correct request to the given base_url", %{bypass: bypass} do
      seq_num = 1
      api_key = "the_key"
      expected_matches = [%{"id" => 123}]

      Bypass.expect(bypass, fn conn ->
        assert "GET" == conn.method
        assert "/GetMatchHistoryBySequenceNum/v0001/" == conn.request_path

        assert String.contains?(conn.query_string, "start_at_match_seq_num=#{seq_num}")
        assert String.contains?(conn.query_string, "key=#{api_key}")

        response =
          Jason.encode!(%{
            result: %{
              matches: expected_matches
            }
          })

        Plug.Conn.resp(conn, 200, response)
      end)

      assert Valve.match_history(seq_num, api_key, base_url: "http://localhost:#{bypass.port}") ==
               {:ok, expected_matches}
    end

    @tag :external
    test "it makes a correct request to the real valve API"
  end
end
