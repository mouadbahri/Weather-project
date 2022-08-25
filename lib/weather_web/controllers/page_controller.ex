defmodule WeatherWeb.PageController do
  use WeatherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch(conn, _params) do
    case Weather.get_all() do
      %Weather.Location{} = locations ->
        json(conn, Map.take(locations, Weather.Location.fields()))

      nil ->
        IO.puts("Weather data not found")
    end
  end
end
