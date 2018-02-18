defmodule ScreenerWeb.HistoryController do
  use ScreenerWeb, :controller
  alias ScreenerWeb.Models.Helpers

  def show(conn, %{"ticker" => ticker}) do
    results = Helpers.get_stock_quote(ticker)

    api_response =
    case results do
      { :error, reason } -> { :error, reason }
      { :ok, quotes } -> quotes
    end

    render conn, "show.html", history: api_response
  end

end
