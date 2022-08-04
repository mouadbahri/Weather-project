import Config

config :weather, Weather.Repo,
  database: "weather_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :weather, ecto_repos: [Weather.Repo]

config :weather, Oban, testing: :inline,
  repo: Weather.Repo,
  plugins: [
    {Oban.Plugins.Cron,
     crontab: [
       {"* * * * *", Weather.Get_data}
     ]}
  ],
  queues: [default: 10]

import_config "#{config_env()}.exs"
