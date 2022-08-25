defmodule Weather do

  use Ecto.Schema

  import Ecto.Query

  alias Weather.Repo
  alias Weather.Location

  # alias __MODULE__

  @weather_url "https://api.openweathermap.org/data/2.5/find?units=metric&type=accurate&mode=json"

  def get_weather_for_all_cameras() do
    # Get cameras
    # call weather data for the camera
    # filter nil values
    # Save the data to the database
  end

  def locations() do
    list = ["London", "Paris", "Dublin", "Oran"]
    list
    |> Enum.each(fn location ->
      weather_data(location)
    end)
  end

  def weather_data(location) do
    #Change location here add this to the fonction name (location) and change &q=London to &q=#{location}
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

  defp get_weather_url() do
    app_id = Application.get_env(:weather, :weather_api_id)
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
    |> Repo.insert()
  end

  def get_all() do
    Repo.all(from(Location))
  end
end
