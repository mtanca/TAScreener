defmodule Screener.RelativeStrengthIndex do
  alias ScreenerWeb.Models.Helpers.Math, as: MathHelper
  @moduledoc """
    Relative Strength Index (RSI) is a momentum oscillator that measures the speed and change of price movements.
    Traditionally, and according to Wilder, RSI is considered overbought when above 70 and oversold when below 30.
    Signals can also be generated by looking for divergences, failure swings, and centerline crossovers.
    RSI can also be used to identify the general trend.

    Formula:
                      100
        RSI = 100 - --------
                     1 + RS
       * RS = Average Gain / Average Loss
  """

    def rsi(data, period) do
      avg_gain = average_gain(data, period)
      avg_loss = average_loss(data, period)

      rsi = 100 - 100 / ((avg_gain / avg_loss) + 1)

      %{"RSI" => rsi}
    end

    defp average_gain(data,period) do
      data
      |> Enum.take(period + 1)
      |> Enum.reverse
      |> gains
      |> MathHelper.calculate_average
    end

    defp average_loss(data, period) do
      data
      |> Enum.take(period + 1)
      |> Enum.reverse
      |> losses
      |> MathHelper.calculate_average
    end

    defp format(results) do
      results
      |> List.flatten()
      |> Enum.map(fn(result) -> Float.round(result, 2) end)
    end

    # REWRITE/CONSOLIDATE GAINS & LOSSES FUNCTIONS INTO ONE FUNCTION!!!
    defp gains(data, diff \\ [])
    defp gains([list_element], diff), do: format(diff)
    defp gains(data, diff) do
      first_element = Enum.at(data, 0)
      second_element = Enum.at(data, 1)
      new_list = Enum.slice(data, 1..-1)

      case {first_element, second_element} do
        {x,y} when y > x -> gains(new_list, [diff, y-x])
        _ -> gains(new_list, diff)
      end
    end

    defp losses(data, diff \\ [])
    defp losses([list_element], diff), do: format(diff)
    defp losses(data, diff) do
      first_element = Enum.at(data, 0)
      second_element = Enum.at(data, 1)
      new_list = Enum.slice(data, 1..-1)

      case {first_element, second_element} do
        {x,y} when y < x -> losses(new_list, [diff, x-y])
        _ -> losses(new_list, diff)
      end
    end
end
