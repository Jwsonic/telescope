defmodule Telescope.Valve.ImplTest do
  use Telescope.DataCase

  alias Telescope.Config
  alias Telescope.Valve.Impl

  import Telescope.Factory

  describe "Impl.init/0" do
    test "it schedules a fetch" do
      Impl.init()

      assert_receive :fetch, 5_000
    end
  end

  describe "Impl.fetch" do
    setup do
      bypass = Bypass.open()

      Config.put_valve_base_url("http://localhost:#{bypass.port}/")

      on_exit(&Config.reload_valve_base_url/0)

      {:ok, bypass: bypass}
    end

    test "it makes a call to the valve API and schedules a fetch", %{bypass: bypass} do
      match_seq_num = :seq_num |> insert() |> Map.get(:match_seq_num)
      expected_matches = [%{"id" => 123}]

      Bypass.expect_once(bypass, fn conn ->
        assert "GET" == conn.method
        assert "/GetMatchHistoryBySequenceNum/v0001/" == conn.request_path

        assert String.contains?(conn.query_string, "start_at_match_seq_num=#{match_seq_num}")
        assert String.contains?(conn.query_string, "key=#{Config.valve_api_key!()}")

        response =
          Jason.encode!(%{
            result: %{
              matches: expected_matches
            }
          })

        Plug.Conn.resp(conn, 200, response)
      end)

      Impl.fetch()

      assert_receive :fetch, 2_000
    end
  end
end
