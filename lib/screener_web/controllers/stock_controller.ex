defmodule ScreenerWeb.StockController do
  alias ScreenerWeb.Symbol
  use ScreenerWeb, :controller

  def index(conn, _params) do
    symbols = Symbol.get_symbols |> Enum.sort

    render conn, "index.html", symbols: symbols
  end

end
