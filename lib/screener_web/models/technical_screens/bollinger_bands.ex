defmodule ScreenerWeb.BollingerBands do

  def bollinger_bands(data, period \\ 20) do
    average = data
    |> get_closing_prices(period)
    |> calculate_moving_average

    std = data
    |> get_closing_prices(period)
    |> calculate_standard_deviation

    get_bands(average, std)
  end

  # BREAK OUT INTO SMALLER FUNCTIONS!!!
  def get_closing_prices(data, period) do
    data
    |> find_closing_prices
    |> prices_to_list
    |> closing_prices_to_int
    |> Enum.take(period)
  end

  def find_closing_prices(data) do
    Enum.map(data, fn { _date, value } ->
      Enum.find(value, fn { k, v } -> k == "4. close"  end) end)
  end

  def prices_to_list(tuple) do
    Enum.map(tuple, fn { _key, closing_prices } -> closing_prices end)
  end

  def closing_prices_to_int(list) do
    list
    |> Enum.map(fn price -> Float.parse(price) end)
    |> Enum.map(fn { price, _string } -> price end)
  end

  def calculate_moving_average(closing_prices) do
    Statistics.mean(closing_prices)
  end

  def calculate_standard_deviation(prices) do
    Statistics.stdev(prices)
  end

  def get_bands(avg, std) do
    %{ lower_band: lower_band(avg, std), upper_band: upper_band(avg, std) }
  end

  defp lower_band(average, std) do
    average - (2 * std)
  end

  defp upper_band(average, std) do
    average + (2 * std)
  end

end
