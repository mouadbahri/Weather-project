defmodule WeatherWeb.PageController do
  use WeatherWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def fetch(conn, _params) do
    case Weather.get_by(location: ) do
      %Weather.Location{} = locations ->
        json(conn, Map.take(analytics_parameters, Weather.fields()))

      nil ->
        render_error(conn, 404, "Weather not found for  '#{location}'")
    end
  end
end
