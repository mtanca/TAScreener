defmodule ScreenerWeb.Controllers.Helpers do
  alias ScreenerWeb.Models.StockQuote
  alias ScreenerWeb.Models.TechnicalAnalysis, as: TA

  def get_quote_with_indicators(quotes) do
    q = Task.async fn -> StockQuote.retrieve_latest_quote(quotes) end
    indicators = TA.get_indicators(quotes)

    %{data: Task.await(q), technical_indicators: indicators}
  end

  def get_quote_with_indicators(quotes) do
    indicators = TA.get_indicators(quotes)

    %{data: quotes, technical_indicators: indicators}
  end

  def handle_error(error_msg) do
    %{data: {:error, error_msg}}
  end
end
