defmodule ProcessInput do
  @endpoint "https://data.sfgov.org/resource/rqzj-sfat.json"

  def run({lon, lat}) do
    get()
    |> Enum.map(&update_entry({lon, lat}, &1))
    |> Enum.sort(&(&1["distance"] <= &2["distance"]))
    |> report()
  end

  def get(endpoint \\ @endpoint) when is_binary(endpoint) do
    case HTTPoison.get(endpoint, headers()) do
      {:ok, response} -> process_response(response.body)
      {:error, reason} -> IO.inspect(reason)
    end
  end

  defp process_response(body) when is_binary(body) do
    Jason.decode!(body, [])
    |> Enum.filter(fn x -> x["status"] == "APPROVED" end)
  end

  defp report(list) do
    Enum.each(list, fn x ->
      IO.puts("Applicant: " <> x["applicant"])
      IO.puts("Type: " <> x["facilitytype"])
      IO.puts("Items: " <> x["fooditems"])
      IO.puts("Address: " <> x["address"])
      IO.puts("Location: " <> to_string(x["locationdescription"]))
      IO.puts("Latitude: " <> x["latitude"])
      IO.puts("Longitude: " <> x["longitude"])
      IO.puts("Distance: " <> to_string(x["distance"]))
      IO.puts("Bearing: " <> to_string(x["bearing"]))
      IO.puts(x["objectid"])
      IO.puts("\n\n")
      end)
  end

  defp get_lat_lon(entry) do
    {convert(entry["latitude"]), convert(entry["longitude"])}
  end

  defp convert(s) when s == "0" do
    0.0
  end

  defp convert(s) do
    s |> String.to_float()
  end

  def update_entry(input, entry) do
    lat_lon = get_lat_lon(entry)
    update_entry(input, entry, lat_lon)
  end

  defp update_entry(_input, entry, {lat, lon})
       when lat == 0.0 or
              lon == 0.0 do
    Map.put(entry, "distance", 0)
    |> Map.put("bearing", 0)
  end

  defp update_entry(input, entry, lat_lon) do
    Map.put(entry, "distance", GeoMath.distance(input, lat_lon))
    |> Map.put("bearing", GeoMath.bearing(input, lat_lon))
  end

  defp headers() do
    [{"Content-type", "application/json"}]
  end
end
