defmodule ScreenerWeb.HistoryController do
  use ScreenerWeb, :controller
  alias ScreenerWeb.Controllers.Helpers

  def show(conn, %{"ticker" => ticker}) do
    results = Helpers.get_stock_quotes(ticker)

    response =
    case results do
      {:error, reason} -> {:error, reason}
      {:ok, quotes} -> quotes
    end

    render conn, "show.html", history: response
  end

end
