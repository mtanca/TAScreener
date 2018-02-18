defmodule ScreenerWeb.StockQuoteView do
  use ScreenerWeb, :view

  def capitalize(field) do
    String.capitalize(field)
  end

  # api comes back as: 1.) close
  def remove_non_letter_chars(field) do
    field
    |> String.split(" ")
    |> Enum.at(1)
  end

  def to_int(number) do
    { integer, _ } = Float.parse(number)
    Float.round(integer, 3)
  end

end
