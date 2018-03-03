defmodule ScreenerWeb.Models.StockQuote do
  @moduledoc """
  """

  def retrieve_latest_quote(quotes) do
    Enum.take(quotes, 1)
  end

end
