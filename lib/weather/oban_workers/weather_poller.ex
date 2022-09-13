defmodule Weather.ObanWorkers.WeatherPoller do
  use Oban.Worker, queue: :default, max_attempts: 3

  @cities ["London", "Paris", "Dublin", "Oran"]

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    Weather.fetch_all(@cities)
  end
end
