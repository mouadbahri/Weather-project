defmodule WeatherWeb.PageController do
  use WeatherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch(conn, %{"location" => location}) do
    case Weather.get_by(location) do
      %Weather.Location{} = locations ->
        json(conn, Map.take(locations, Weather.Location.fields()))

      nil ->
        IO.puts("Weather not found for  '#{location}'")
    end
  end
end
