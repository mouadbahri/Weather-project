import Config

config :weather,
  weather_api_id: System.fetch_env!("WEATHER_API_ID")
