defmodule ScreenerWeb.TechnicalAnalysis do
  alias ScreenerWeb.BollingerBands

  def get_indicators(quotes) do
    bb = BollingerBands.bollinger_bands(quotes)
    %{"Bollinger Bands" => bb}
  end

  # def bollinger_bands_analysis(bbands, current_price) do
  #   case {bbands.lower_band, price} do
  #       {x, y} when y < x -> {:ok, %{signal: "oversold", indicator: "Bollinger Band", value: bolling_bands.lower_band}}
  #       _ -> nil
  #   end
  #
  #   case {bbands.upper_band, price} do
  #       {x, y} when y > x -> {:ok, %{signal: "overbought", indicator: "Bollinger Band", value: bolling_bands.upper_band}}
  #       _ -> nil
  #   end
  # end

end
