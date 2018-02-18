defmodule ScreenerWeb.StockView do
  use ScreenerWeb, :view

  def char_to_string(x) do
    List.to_string([x])
  end

end
