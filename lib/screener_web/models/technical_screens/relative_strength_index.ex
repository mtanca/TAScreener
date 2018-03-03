defmodule ScreenerWeb.Models.RelativeStrengthIndex do
  alias ScreenerWeb.Models.Helpers.Math, as: MathHelper
  alias ScreenerWeb.Models.Helpers.Quotes, as: QuoteHelper
  @moduledoc """
    Relative Strength Index (RSI) is a momentum oscillator that measures the speed and change of price movements.

    Formula:
                      100
        RSI = 100 - --------
                     1 + RS
        RS = Average Gain / Average Loss
  """

  def rsi(data, period \\ 14) do
    rsi = data
    |> QuoteHelper.get_closing_prices(period)
    |> relative_strength(period)
    |> calculate_rsi

    %{"index value" => rsi}
  end

  # PRIVATE FUNCTIONS
  defp avg_gain_loss(data, gains \\ [], losses \\ [])

  defp avg_gain_loss([last_element], gains, losses) do
    Enum.map([gains, losses], fn(list) -> format(list) end)
  end

  defp avg_gain_loss(data, gains, losses) do
    [older, newer] = [Enum.at(data, 0), Enum.at(data, 1)]
    list = Enum.slice(data, 1..-1)

    case {older, newer} do
      {x, y} when y > x -> avg_gain_loss(list, [gains, y - x], losses)
      {x, y} when y < x -> avg_gain_loss(list, gains, [losses, x - y])
      _ -> "Raise Error Here"
    end
  end

  defp calculate_averages(lists, period) do
    Enum.map(lists, fn(list) -> MathHelper.calculate_average(list) / period end)
  end

  defp calculate_rsi(rs) do
    100 - 100 / (1 + rs)
  end

  defp divide(lists) do
    Enum.at(lists, 0) / Enum.at(lists, 1)
  end

  defp format(results) do
    results
    |> List.flatten
    |> Enum.map(fn(result) -> Float.round(result, 2) end)
  end

  defp relative_strength(data, period) do
    data
    |> Enum.take(period + 1)
    |> Enum.reverse
    |> avg_gain_loss
    |> calculate_averages(period)
    |> divide
  end

end
