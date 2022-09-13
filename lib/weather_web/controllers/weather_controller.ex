defmodule WeatherWeb.WeatherController do
  use WeatherWeb, :controller

  def index(conn, params) do
    render(conn, "index.json", %{data: Weather.all(params)})
  end
end
