defmodule TelescopeTest do
  use ExUnit.Case
  doctest Telescope

  test "greets the world" do
    assert Telescope.hello() == :world
  end
end
