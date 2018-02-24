defmodule ScreenerWeb.Controllers.Helpers do
  alias ScreenerWeb.BollingerBands

  @moduledoc """
  """

  def get_technical_indicators(data) do
    BollingerBands.bollinger_bands(data)
  end

  def get_stock_quotes(ticker) do
    key  = System.get_env("API_KEY")
    url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{ticker}&apikey=#{key}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> convert_json
        |> handle_status_200
      {:error, %HTTPoison.Error{reason: reason}} ->
        return_error_status(reason)
    end
  end

  # PRIVATE FUNCTIONS
  defp convert_json(quotes_as_json) do
    Poison.decode(quotes_as_json)
  end

  defp handle_status_200(data) do
    case data do
      {:ok, %{"Error Message" => error_msg}} ->
        return_error_status(error_msg)
      _ ->
        format_results(data)
    end
  end

  defp format_results(results) do
    {_status, data} =  results
    quotes = data["Time Series (Daily)"]

    quotes
    |> sort_by_descending_date
    |> return_ok_status
  end

  defp sort_by_descending_date(formatted_data) do
    formatted_data
    |> Enum.sort
    |> Enum.reverse
  end

  defp return_error_status(item) do
    {:error, item}
  end

  defp return_ok_status(item) do
    {:ok, item}
  end

end
