defmodule WeatherWeb.PageController do
  use WeatherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch(conn, location) do
    case Weather.get_by(location: location) do
      %Weather.Location{} = locations ->
        json(conn, Map.take(locations, Weather.fields()))

      # nil ->
      #   render_error(conn, 404, "Weather not found for  '#{location}'")
    end
  end
end
