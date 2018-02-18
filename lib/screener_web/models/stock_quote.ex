defmodule ScreenerWeb.StockQuote do

  @base_path System.get_env("QUOTE_BASE_PATH")
  @key System.get_env("API_KEY")

  def get_stock_quote(ticker) do
    url = "#{@base_path}&symbol=#{ticker}&apikey=#{@key}"

    case HTTPoison.get(url) do
      { :ok, %HTTPoison.Response{status_code: 200, body: body} } ->
        body
      { :error, %HTTPoison.Error{reason: reason} } ->
        { "Error Message", reason }
    end
  end

  def handle_response(data_as_json) do
    response =  convert_json(data_as_json)

    case response do
      { :ok, %{"Error Message" => error_msg} } ->
        {:error, error_msg }
      _ ->
        format_results(response)
    end
  end

  # PRIVATE FUNCTIONS
  defp convert_json(quotes_as_json) do
    Poison.decode(quotes_as_json)
  end

  defp format_results(results) do
    { _status, data } =  results
    quotes = data["Time Series (Daily)"]

    quotes
    |> sort_by_ascending_date
    |> retrieve_latest_quote
  end

  defp sort_by_ascending_date(formatted_data) do
    Enum.sort(formatted_data)
  end

  defp retrieve_latest_quote(quotes) do
    Enum.take(quotes, -1)
  end

end
