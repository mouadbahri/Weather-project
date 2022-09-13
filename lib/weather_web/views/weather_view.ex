defmodule WeatherWeb.WeatherView do
  use WeatherWeb, :view

  def render("index.json", %{data: data}) do
    Enum.map(data, fn weather_record ->
      Map.take(weather_record, [
        :id,
        :name,
        :temp,
        :humidity,
        :pressure,
        :windspeed,
        :winddeg,
        :updated_at,
        :inserted_at
      ])
    end)
  end
end
