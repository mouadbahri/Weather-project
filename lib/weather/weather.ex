defmodule Weather do

  use Ecto.Schema

  alias Weather.Repo
  alias Weather.Location

  @weather_url "https://api.openweathermap.org/data/2.5/find?units=metric&type=accurate&mode=json"

  def fetch_all(cities) do
    Enum.reduce_while(cities, :ok, fn city, acc ->
      case fetch(city) do
        {:ok, _location} -> {:cont, acc}
        {:error, :no_result} -> {:cont, acc}
        error -> {:halt, error}
      end
    end)
  end

  def fetch(location) do
    url = "#{get_weather_url()}&q=#{location}"
    request = Finch.build(:get, url)

    with {:ok, %{body: body, status: 200}} <- Finch.request(request, WeatherHTTP),
         %Location{} = location <- map_record_to_day(Jason.decode!(body)) do
      Repo.insert(location)
    else
      nil ->
        {:error, :no_result}

      {:ok, %{body: body}} ->
        {:error, Jason.decode!(body)}

      other ->
        other
    end
  end

  defp get_weather_url() do
    # This bit here is changed due to the hosting service not reading the id corretly from the congif file.
    app_id = "3973696edaa078dc71daa0d1ce0ddfb5" #Application.get_env(:weather, :weather_api_id)
    "#{@weather_url}&APPID=#{app_id}"
  end

  defp map_record_to_day(record) do
    if record = List.first(record["list"]) do
      %Location{
        name: record["name"],
        temp: record["main"]["temp"],
        pressure: record["main"]["pressure"],
        humidity: record["main"]["humidity"],
        windspeed: record["wind"]["speed"],
        winddeg: record["wind"]["deg"]
      }
    end
  end
end
