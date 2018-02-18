defmodule ScreenerWeb.Models.Helpers do
  @key System.get_env("API_KEY")

  def get_stock_quote(ticker) do
    url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{ticker}&apikey=#{@key}"

    case HTTPoison.get(url) do
      { :ok, %HTTPoison.Response{status_code: 200, body: body} } ->
        body
        |> convert_json
        |> handle_response
      { :error, %HTTPoison.Error{reason: reason} } ->
        return_error_status(reason)
    end
  end

  # PRIVATE FUNCTIONS
  defp convert_json(quotes_as_json) do
    Poison.decode(quotes_as_json)
  end

  defp handle_response(data) do
    case data do
      { :ok, %{"Error Message" => error_msg} } ->
        return_error_status(error_msg)
      _ ->
        format_results(data)
    end
  end

  defp format_results(results) do
    { _status, data } =  results
    quotes = data["Time Series (Daily)"]

    quotes
    |> sort_by_descending_date
    |> return_ok_status
  end

  defp sort_by_descending_date(formatted_data) do
    Enum.sort(formatted_data) |> Enum.reverse
  end

  defp return_error_status(item) do
    { :error, item }
  end

  defp return_ok_status(item) do
    { :ok, item }
  end

end
