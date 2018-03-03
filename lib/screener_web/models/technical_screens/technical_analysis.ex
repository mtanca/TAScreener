defmodule ScreenerWeb.Models.TechnicalAnalysis do
  alias ScreenerWeb.Models.BollingerBands
  alias ScreenerWeb.Models.RelativeStrengthIndex
  alias ScreenerWeb.Models.RegressionPoints

  def get_indicators(quotes) do
    bb = Task.async fn -> BollingerBands.bollinger_bands(quotes) end
    rsi = Task.async fn -> RelativeStrengthIndex.rsi(quotes) end
    reg = RegressionPoints.regression_points(quotes)
    # reg = Task.async fn -> RegressionPoints.regression_points(quotes) end

    %{
      "Bollinger Bands" => Task.await(bb),
      "RSI" => Task.await(rsi),
      # "Regression Points" => Task.await(reg)
    }
  end

end
