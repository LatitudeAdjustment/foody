defmodule ProcessInputTest do
  use ExUnit.Case
  alias GeoMath
  alias ProcessInput

  def input() do
    {37.7574, -122.4377}
  end

  def vendor_1660697() do
    %{
      "address" => "505 HOWARD ST",
      "applicant" => "Truly Food & More",
      "facilitytype" => "Truck",
      "fooditems" => "Latin Food: Tacos: Pupusas: Vegetables: Salad: Waters: Sodas",
      "latitude" => "37.78798864899528",
      "location" => %{
        "human_address" => "{\"address\": \"\", \"city\": \"\", \"state\": \"\", \"zip\": \"\"}",
        "latitude" => "37.78798864899528",
        "longitude" => "-122.39610066847152"
      },
      "locationdescription" => "01ST ST: HOWARD ST to TEHAMA ST (200 - 231)",
      "longitude" => "-122.39610066847152",
      "objectid" => "1660697",
      "status" => "APPROVED"
    }
  end

  test "Updates entry with distance and bearing from input" do
    entry = ProcessInput.update_entry(input(), vendor_1660697())

    assert entry["distance"] == 3.106447252772325
    assert entry["bearing"] == 47.05665739424967
  end
end
