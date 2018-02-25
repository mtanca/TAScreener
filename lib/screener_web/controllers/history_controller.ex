defmodule ScreenerWeb.HistoryController do
  alias ScreenerWeb.Controllers.Helpers
  alias ScreenerWeb.Models.Helpers.API, as: Model
  use ScreenerWeb, :controller

  def show(conn, %{"ticker" => ticker}) do
    results = Model.get_stock_quotes(ticker)

    response =
    case results do
      {:error, reason} -> Helpers.handle_error(reason)
      {:ok, quotes} -> Helpers.get_quotes_and_indicators(quotes)
    end

    render conn, "show.html", response: response
  end

end
