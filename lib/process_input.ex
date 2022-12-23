defmodule ProcessInput do
  @endpoint "https://data.sfgov.org/resource/rqzj-sfat.json"

  def get(endpoint \\ @endpoint) when is_binary(endpoint) do
    case HTTPoison.get(endpoint, headers()) do
      {:ok, response} -> process_response(response.body)

      {:error, reason} -> IO.inspect(reason)
    end
  end

  defp process_response(body) when is_binary(body) do
    Jason.decode!(body, [])
    |> Enum.filter(fn x -> x["status"] == "APPROVED" end)
    |> Enum.sort(&(&1["applicant"] <= &2["applicant"]))
    |> range()
    |> output_all()
  end

  def range(list) when is_list(list) do
    Enum.map(list, fn x ->
      Map.put(x, "range", 0)
      end)
  end

  defp output_all(list) when is_list(list) do
    Enum.each(list, fn x ->
      IO.inspect(x)
    end)
  end

  defp headers() do
    [{"Content-type", "application/json"}]
  end
end
