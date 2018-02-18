defmodule ScreenerWeb.StockController do
  use ScreenerWeb, :controller
  alias ScreenerWeb.Symbol

  def index(conn, _params) do
    symbols = Symbol.get_symbols
    |> Enum.sort

    render conn, "index.html", symbols: symbols
  end

end
