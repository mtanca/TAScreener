defmodule ScreenerWeb.StockQuoteController do
  use ScreenerWeb, :controller
  alias ScreenerWeb.StockQuote

  def show(conn, %{"ticker" => ticker}) do
    api_response =

    ticker
    |> StockQuote.get_stock_quote
    |> StockQuote.handle_response

    render conn, "show.html", response: api_response
  end

end
