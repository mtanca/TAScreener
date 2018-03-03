defmodule ScreenerWeb.Models.RegressionPoints do
  alias ScreenerWeb.Models.Helpers.Quotes, as: QuoteHelper
  @moduledoc """
    Work in progress...
  """

  def regression_points(data, period \\ 20) do
    coordinates = get_axee_values(data, period)
    means = coordinates |> calculate_averages

    slope = calculate_slope(coordinates, means)
  end

  # PRIVATE FUNCTIONS
  defp get_axee_values(data, period) do
    x = QuoteHelper.get_weighted_prices(data, period)
    y = Enum.to_list 0..length(x)

    %{x_values: x, y_values: y}
  end

  defp calculate_averages(map) do
    x_mean = Statistics.mean(map.x_values)
    y_mean = Statistics.mean(map.y_values)

    %{x_value_mean: x_mean, y_value_mean: y_mean}
  end

  defp calculate_slope(coordinates, means) do

  end
end
