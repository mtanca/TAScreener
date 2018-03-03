defmodule ScreenerWeb.Models.Helpers.Quotes do
  alias ScreenerWeb.Models.Helpers.Math, as: MathHelper
  @moduledoc """
    Helper functions specifically for handling quote data
  """

  def get_closing_prices(data, period) do
    data
    |> find_closing_prices
    |> transform(period)
  end

  def get_highs(data, period) do
    data
    |> find_highs
    |> transform(period)
  end

  def get_lows(data, period) do
    data
    |> find_lows
    |> transform(period)
  end

  def get_weighted_prices(data, period) do
    highs = get_highs(data, period)
    lows = get_lows(data, period)

    MathHelper.calculate_weighted_prices(highs, lows)
  end

  # PRIVATE FUNCTIONS
  defp convert_prices_to_int(prices) do
    prices
    |> Enum.map(fn price -> Float.parse(price) end)
    |> Enum.map(fn {price, _empty_string} -> price end)
  end

  # RELOOK AT THIS!!!
  # Pass in field as second argument to reduce these fucntions down to one...
  # Example: find_closing_prices(data, search_field) => fn {field, value} -> field == search_field
  defp find_closing_prices(data) do
    Enum.map(data, fn {_date, single_quote} ->
      Enum.find(single_quote, fn {field, value} -> field == "4. close"  end) end)
  end

  defp find_highs(data) do
    Enum.map(data, fn {_date, single_quote} ->
      Enum.find(single_quote, fn {field, value} -> field == "2. high"  end) end)
  end

  defp find_lows(data) do
    Enum.map(data, fn {_date, single_quote} ->
      Enum.find(single_quote, fn {field, value} -> field == "3. low"  end) end)
  end

  defp format_as_list(tuple) do
    Enum.map(tuple, fn {_key, price} -> price end)
  end

  defp transform(data, period) do
    data
    |> format_as_list
    |> convert_prices_to_int
    |> Enum.take(period)
  end

end
