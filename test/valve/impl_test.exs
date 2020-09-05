defmodule Telescope.Valve.ImplTest do
  use Telescope.DataCase

  alias Telescope.Config
  alias Telescope.Valve.Impl

  setup do
    bypass = Bypass.open()

    Config.put_valve_base_url("http://localhost:#{bypass.port}/")

    Bypass.stub(bypass, "GET", "GetMatchHistoryBySequenceNum/v0001/", fn conn ->
      response =
        Jason.encode!(%{
          result: %{
            matches: []
          }
        })

      Plug.Conn.resp(conn, 200, response)
    end)

    on_exit(&Config.reload_valve_base_url/0)

    :ok
  end

  describe "Impl.init/0" do
    test "it schedules a fetch" do
      Impl.init()

      assert_receive :fetch, 10_000
    end
  end

  describe "Impl.fetch" do
    test "it makes a call to the valve API" do
      Impl.fetch()

      assert_receive :fetch, 10_000
    end
  end
end
