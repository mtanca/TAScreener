defmodule ScreenerWeb.TechnicalAnalysis do
  alias ScreenerWeb.BollingerBands

  def get_indicators(quotes) do
    bb = BollingerBands.bollinger_bands(quotes)
    %{"Bollinger Bands" => bb}
  end

end
