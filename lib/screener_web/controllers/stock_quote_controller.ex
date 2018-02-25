defmodule ScreenerWeb.StockQuoteController do
  alias ScreenerWeb.StockQuote
  alias ScreenerWeb.Models.Helpers, as: Model
  alias ScreenerWeb.TechnicalAnalysis, as: TA
  use ScreenerWeb, :controller

  def show(conn, %{"ticker" => ticker}) do
    results = Model.get_stock_quotes(ticker)

    response =
    case results do
      {:error, reason} -> {:error, reason}
      {:ok, quotes} -> StockQuote.retrieve_latest_quote(quotes)
    end

    indicators = TA.get_indicators(elem(results,1))

    render conn, "show.html", response: %{data: response, technical_indicators: indicators}
  end

end
