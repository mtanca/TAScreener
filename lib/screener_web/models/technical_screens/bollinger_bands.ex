defmodule ScreenerWeb.BollingerBands do
  @moduledoc """

  Bollinger Bands® are volatility bands placed above and below a moving average.
  Volatility is based on the standard deviation, which changes as volatility increases and decreases.

  Steps:
  1.) Middle Band = 20-day simple moving average (SMA)
  2.) Upper Band = 20-day SMA + (20-day standard deviation of price x 2)
  3.) Lower Band = 20-day SMA - (20-day standard deviation of price x 2)

 """

  def bollinger_bands(data, period \\ 20) do
    average = data
    |> get_closing_prices(period)
    |> calculate_moving_average

    std = data
    |> get_closing_prices(period)
    |> calculate_standard_deviation

    get_bands(average, std)
  end

  # PRIVATE FUNCTIONS
  defp calculate_moving_average(closing_prices) do
    Statistics.mean(closing_prices)
  end

  defp calculate_standard_deviation(prices) do
    Statistics.stdev(prices)
  end

  defp convert_prices_to_int(prices) do
    prices
    |> Enum.map(fn price -> Float.parse(price) end)
    |> Enum.map(fn {price, _empty_string} -> price end)
  end

  defp find_closing_prices(data) do
    Enum.map(data, fn {_date, single_quote} ->
      Enum.find(single_quote, fn {field, value} -> field == "4. close"  end) end)
  end

  defp format_prices_as_list(tuple) do
    Enum.map(tuple, fn {_key, closing_prices} -> closing_prices end)
  end

  defp get_bands(avg, std) do
    %{"Lower Band" => lower_band(avg, std), "Upper Band" => upper_band(avg, std)}
  end

  def get_closing_prices(data, period) do
    data
    |> find_closing_prices
    |> format_prices_as_list
    |> convert_prices_to_int
    |> Enum.take(period)
  end

  defp lower_band(average, std) do
    average - (2 * std)
  end

  defp upper_band(average, std) do
    average + (2 * std)
  end

end
