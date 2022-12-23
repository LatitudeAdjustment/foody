defmodule FoodyTest do
  use ExUnit.Case
  doctest Foody

  test "greets the world" do
    assert Foody.hello() == :world
  end
end
