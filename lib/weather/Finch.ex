defmodule Weather.OpenWeatherMap do

  def child_spec do
    Finch.child_spec(name: Weather.Finch)
  end
end
