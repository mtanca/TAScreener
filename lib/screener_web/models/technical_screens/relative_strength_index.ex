defmodule Screener.RelativeStrengthIndex do
  alias ScreenerWeb.Models.Helpers.Math, as: MathHelper
  @moduledoc """
    Relative Strength Index (RSI) is a momentum oscillator that measures the speed and change of price movements.
    Traditionally, and according to Wilder, RSI is considered overbought when above 70 and oversold when below 30.

    Formula:
                      100
        RSI = 100 - --------
                     1 + RS
       * RS = Average Gain / Average Loss
  """

  def rsi(data, period \\ 14) do
    rs = relative_strength(data, period)
    rsi = 100 - 100 / (1 + rs)

    %{"RSI" => rsi}
  end

  defp relative_strength(data, period) do
    data
    |> Enum.take(period + 1)
    |> Enum.reverse
    |> average_gain_loss
    |> calculate_averages
    |> divide
  end

  defp calculate_averages(map) do
    Enum.map(map, fn{_key, list} ->
      Enum.reduce(list, 0, fn(x, acc) -> x + acc end) / 14 end)
  end

  defp divide(lists) do
    Enum.at(lists, 0) / Enum.at(lists, 1)
  end

  defp format(results) do
    results
    |> List.flatten
    |> Enum.map(fn(result) -> Float.round(result, 2) end)
  end

  defp average_gain_loss(data, gains \\ [], losses \\ [])

  defp average_gain_loss([last_element], gains, losses) do
    results = Enum.map([gains, losses], fn(list) -> format(list) end)

    %{gains: Enum.at(results, 0), losses: Enum.at(results, 1)}
  end

  defp average_gain_loss(data, gains, losses) do
    first_element = Enum.at(data, 0)
    second_element = Enum.at(data, 1)

    list = Enum.slice(data, 1..-1)

    case {first_element, second_element} do
      {x, y} when y > x -> average_gain_loss(list, [gains, y-x], losses)
      {x, y} when y < x -> average_gain_loss(list, gains, [losses, x-y])
      _ -> "Raise Error Here"
    end
  end
end
