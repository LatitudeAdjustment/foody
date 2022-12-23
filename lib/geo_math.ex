defmodule GeoMath do
  # earth's mean radius
  # Kilometers
  @km_radius 6371
  # Nautical miles
  @nm_radius 3440.07
  # Statute miles
  @sm_radius 3963.19

  def km_radius(), do: @km_radius

  def nm_radius(), do: @nm_radius

  def sm_radius(), do: @sm_radius

  @spec distance({number, number}, {number, number}, number) :: float
  def distance(pointa, pointb, radians \\ @sm_radius) do
    distance_haversine(pointa, pointb) * radians
  end

  @spec bearing({number, number}, {number, number}) :: float
  def bearing({lat1, lon1}, {lat2, lon2}) do
    lat1_rad = to_radians(lat1)
    lat2_rad = to_radians(lat2)

    diff_lon = to_radians(lon2 - lon1)

    x =
      :math.cos(lat1_rad) * :math.sin(lat2_rad) -
        :math.sin(lat1_rad) *
          :math.cos(lat2_rad) * :math.cos(diff_lon)

    y = :math.sin(diff_lon) * :math.cos(lat2_rad)

    :math.atan2(y, x)
    |> to_degrees()
    |> wrap_360_degrees()
  end

  # Haversine is better than law of cosines for short distances
  defp distance_haversine({lat1, lon1}, {lat2, lon2}) do
    lat1_rad = to_radians(lat1)
    lat2_rad = to_radians(lat2)

    diff_lat = to_radians(lat2 - lat1)
    diff_lon = to_radians(lon2 - lon1)

    a =
      :math.sin(diff_lat / 2) * :math.sin(diff_lat / 2) +
        :math.cos(lat1_rad) * :math.cos(lat2_rad) *
          :math.sin(diff_lon / 2) * :math.sin(diff_lon / 2)

    2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))
  end

  defp to_radians(degrees) do
    degrees / 180.0 * :math.pi()
  end

  defp to_degrees(radians) do
    radians * 180 / :math.pi()
  end

  defp wrap_360_degrees(degrees) when 0 <= degrees and degrees < 360 do
    degrees
  end

  defp wrap_360_degrees(degrees) do
    :math.fmod(360, degrees + 360)
  end
end
