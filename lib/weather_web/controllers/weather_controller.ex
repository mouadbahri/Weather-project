defmodule WeatherWeb.WeatherController do
  use WeatherWeb, :controller

  alias Weather.Repo
  alias Weather.Location

  import Ecto.Query

  # To get all the data that exists in the data base call this function.
  def get_all(conn, _params) do
    weather_data = Repo.all(from(Location))
    json(conn, Enum.map(weather_data, fn weather -> Map.take(weather, [:id, :name, :temp, :humidity, :pressure, :windspeed, :winddeg, :updated_at, :inserted_at])end ))
  end

  # To call data by name call this function.
  def index(conn, %{"name" => name}) do
    capname = String.capitalize(name)
    query = from u in "Locations",
      where: u.name == ^capname,
      select: [
        :id,
        :name,
        :temp,
        :humidity,
        :pressure,
        :windspeed,
        :winddeg,
        :updated_at,
        :inserted_at]
    one_location = Repo.all(query)
    json(conn, one_location)
  end
end
