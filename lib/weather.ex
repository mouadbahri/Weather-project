defmodule Weather do

  use Ecto.Schema

  alias Weather.Repo
  alias Weather.Location

  # alias __MODULE__

  @weather_url "https://api.openweathermap.org/data/2.5/find?units=metric&type=accurate&mode=json"

  # This is the loop function that goes through the list of locations and applies the fetching function.
  def locations() do
    list = ["London", "Paris", "Dublin", "Oran"]
    list
    |> Enum.each(fn location ->
      weather_data(location)
    end)
  end

  # This function is the main fetching function.
  def weather_data(location) do
    url = "#{get_weather_url()}&q=#{location}"
    request = Finch.build(:get, url)

    case Finch.request(request, WeatherHTTP) do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        map_record_to_day(Jason.decode!(body))

      {:ok, %Finch.Response{body: body}} ->
        # error
        Jason.decode!(body)

      {:error, error} ->
        IO.inspect(Exception.message(error))
    end
  end

  # This function prepares the url needed to fetch the data.
  defp get_weather_url() do
    # This bit here is changed due to the hosting service not reading the id corretly from the congif file.
    app_id = "3973696edaa078dc71daa0d1ce0ddfb5" #Application.get_env(:weather, :weather_api_id)
    "#{@weather_url}&APPID=#{app_id}"
  end

  # This function recieves the Json data and stores it in our own database.
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
    |> Repo.insert()
  end
end
