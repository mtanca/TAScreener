defmodule ScreenerWeb.HistoryController do
  use ScreenerWeb, :controller

  def show(conn, %{"ticker" => ticker}) do
    api_response =

    ticker
    |> StockQuote.get_stock_history
    |> StockQuote.handle_response

    render conn, "show.html", response: api_response
  end

end
