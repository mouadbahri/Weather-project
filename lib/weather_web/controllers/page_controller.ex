defmodule WeatherWeb.PageController do
  use WeatherWeb, :controller

  alias Weather.Location
  alias Weather.Repo

  import Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get(conn, _params) do
    weather_data = Repo.all(from(Location))
    json(conn, Enum.map(weather_data, fn weather -> Map.take(weather, [:id, :name, :temp, :humidity, :pressure, :windspeed, :winddeg, :updated_at, :inserted_at])end ))
  end
end
