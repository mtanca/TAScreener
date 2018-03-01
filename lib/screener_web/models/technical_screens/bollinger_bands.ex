defmodule ScreenerWeb.BollingerBands do
  alias ScreenerWeb.Models.Helpers.Math, as: MathHelper
  alias ScreenerWeb.Models.Helpers.Quotes, as: QuoteHelper
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
    |> QuoteHelper.get_closing_prices(period)
    |> MathHelper.calculate_average

    std = data
    |> QuoteHelper.get_closing_prices(period)
    |> MathHelper.calculate_standard_deviation

    get_bands(average, std) 
  end

  # PRIVATE FUNCTIONS
  defp get_bands(avg, std) do
    %{"Lower Band" => lower_band(avg, std), "Upper Band" => upper_band(avg, std)}
  end

  defp lower_band(average, std) do
    average - (2 * std)
  end

  defp upper_band(average, std) do
    average + (2 * std)
  end

end
