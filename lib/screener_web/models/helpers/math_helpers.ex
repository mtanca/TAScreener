defmodule ScreenerWeb.Models.Helpers.Math do
  @moduledoc """
    Helper functions for math related operations...
  """

  def calculate_average(data) do
    Statistics.mean(data)
  end

  def calculate_standard_deviation(data) do
    Statistics.stdev(data)
  end

  def calculate_weighted_prices(highs, lows) do
    for {x, y} <- Enum.zip(highs, lows), do: (x + y) / 2
  end

end
