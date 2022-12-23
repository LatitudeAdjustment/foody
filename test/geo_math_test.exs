defmodule GeoMathTest do
  use ExUnit.Case
  alias GeoMath

  def lax() do
    {33 + 57 / 60, 118 + 24 / 60}
  end

  def jfk() do
    {40 + 38 / 60, 73 + 47 / 60}
  end

  def boulder_colorado() do
    {40.0167, 105.2833}
  end

  def wallaroo_australia() do
    {-33.9333, 137.65}
  end

  test "calculates distance Boulder to Walleroo" do
    assert_in_delta(GeoMath.distance(boulder_colorado(), wallaroo_australia()), 5517, 1)
  end

  test "calculates distance LAX to JFK" do
    assert_in_delta(GeoMath.distance(lax(), jfk(), GeoMath.nm_radius()), 2145, 1)
  end

  test "calculates initial bearing Boulder to Walleroo" do
    assert_in_delta(GeoMath.bearing(boulder_colorado(), wallaroo_australia()), 153, 1)
  end

  test "calculates initial bearing LAX to JFK" do
    assert_in_delta(GeoMath.bearing(lax(), jfk()), 65, 1)
  end
end
