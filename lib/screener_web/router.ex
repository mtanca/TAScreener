defmodule ScreenerWeb.Router do
  use ScreenerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScreenerWeb do
    pipe_through :browser # Use the default browser stack
    get "/stocks", StockController, :index
    get "/stocks/:ticker/history/", HistoryController, :show
    get "/stocks/:ticker/quotes/", StockQuoteController, :show
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScreenerWeb do
  #   pipe_through :api
  # end
end
