defmodule ScreenerWeb.StockQuoteController do
  use ScreenerWeb, :controller
  alias ScreenerWeb.StockQuote
  alias ScreenerWeb.Controllers.Helpers
  alias ScreenerWeb.TechnicalAnalysis, as: TA
  require IEx

  def show(conn, %{"ticker" => ticker}) do
    results = Helpers.get_stock_quotes(ticker)

    response =
    case results do
      {:error, reason} -> {:error, reason}
      {:ok, quotes} -> StockQuote.retrieve_latest_quote(quotes)
    end

    indicators = TA.get_indicators(elem(results,1))

    render conn, "show.html", response: %{data: response, technical_indicators: indicators}
  end

end
