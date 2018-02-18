defmodule ScreenerWeb.StockQuoteController do
  use ScreenerWeb, :controller
  alias ScreenerWeb.StockQuote
  alias ScreenerWeb.Models.Helpers

  def show(conn, %{"ticker" => ticker}) do
    results = Helpers.get_stock_quote(ticker)

    api_response =
    case results do
      { :error, reason } -> { :error, reason }
      { :ok, quotes } -> StockQuote.retrieve_latest_quote(quotes)
    end

    render conn, "show.html", response: api_response
  end

end
