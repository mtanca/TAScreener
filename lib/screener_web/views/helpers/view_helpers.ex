defmodule ScreenerWeb.Views.Helpers do
  require IEx
  @moduledoc """
  """

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
    {integer, _} = Float.parse(number)
    round_int(integer)
  end

  def round_int(number) do
    Float.round(number, 3)
  end

end
