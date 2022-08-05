import Config

config :weather, Weather.Repo,
  database: "weather_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :weather, ecto_repos: [Weather.Repo]

config :weather, Oban,
  repo: Weather.Repo,
  plugins: [
    {Oban.Plugins.Cron,
     crontab: [
       {"0 * * * *", Weather.Workers.WeatherCaller}
     ]}
  ],
  queues: [default: 10]

import_config "#{config_env()}.exs"
