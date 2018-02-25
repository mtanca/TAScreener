defmodule ScreenerWeb.Models.Helpers.Math do
  @moduledoc """
  """

  def calculate_average(data) do
    Statistics.mean(data)
  end

  def calculate_standard_deviation(data) do
    Statistics.stdev(data)
  end

end
