defmodule ScreenerWeb.TechnicalAnalysis do
  alias ScreenerWeb.BollingerBands
  alias Screener.RelativeStrengthIndex

  def get_indicators(quotes) do
    bb = Task.async fn -> BollingerBands.bollinger_bands(quotes) end
    rsi = Task.async fn -> RelativeStrengthIndex.rsi(quotes) end
    %{"Bollinger Bands" => Task.await(bb), "RSI" => Task.await(rsi)}
  end

end
