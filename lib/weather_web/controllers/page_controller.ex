defmodule WeatherWeb.PageController do
  use WeatherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch(conn, name) do
    case Weather.get_by(name: name) do
      %Weather.Location{} = locations ->
        json(conn, Map.take(locations, Weather.Location.fields()))

      nil ->
        IO.puts("Weather not found for '#{name}'")
    end
  end
end
