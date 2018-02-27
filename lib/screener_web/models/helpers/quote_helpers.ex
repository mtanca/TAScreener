defmodule ScreenerWeb.Models.Helpers.Quotes do
  @moduledoc """
    Helper functions specifically for handling API call
  """

  def get_closing_prices(data, period) do
    data
    |> find_closing_prices
    |> format_as_list
    |> convert_prices_to_int
    |> Enum.take(period)
  end

  defp find_closing_prices(data) do
    Enum.map(data, fn {_date, single_quote} ->
      Enum.find(single_quote, fn {field, value} -> field == "4. close"  end) end)
  end

  defp format_as_list(tuple) do
    Enum.map(tuple, fn {_key, closing_prices} -> closing_prices end)
  end

  defp convert_prices_to_int(prices) do
    prices
    |> Enum.map(fn price -> Float.parse(price) end)
    |> Enum.map(fn {price, _empty_string} -> price end)
  end

end
