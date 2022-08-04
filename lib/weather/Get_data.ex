defmodule Weather.Workers.WeatherCaller do
  use Oban.Worker, queue: :default, max_attempts: 3

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    Weather.weather_data()
    :ok
  end
end
