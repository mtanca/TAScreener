defmodule ScreenerWeb.PageController do
  use ScreenerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
