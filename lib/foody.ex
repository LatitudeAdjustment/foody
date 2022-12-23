defmodule Foody do
  @moduledoc """
  Documentation for `Foody`.
  """
  alias ProcessInput

  @doc """
  Hello world.

  ## Examples

      iex> Foody.hello()
      :world

  """
  def main(args \\ []) do
    args
    |> parse_args()
    |> response()
  end

  defp parse_args(args) do
    {parsed, _args, _invalid} =
      args
      |> OptionParser.parse(switches: [lat: :float, lon: :float])

    {parsed}
  end

  defp response({opts}) do
    ProcessInput.run({opts[:lat], opts[:lon]})
  end
end
