defmodule Weather.OpenWeatherMap do

  def child_spec do
    {Finch,
     name: __MODULE__,
     pools: %{
       "https://api.openweathermap.org" => [size: pool_size()]
     }}
  end

  def pool_size, do: 25

  @spec get_weather(any) ::
          {:error, %{:__exception__ => true, :__struct__ => atom, optional(atom) => any}}
          | {:ok, Finch.Response.t()}
  def get_weather(location) do
    :get
    |> Finch.build("https://api.openweathermap.org/data/2.5/find?q=#{location}&units=metric&type=accurate&mode=json&APPID=3973696edaa078dc71daa0d1ce0ddfb5")
    |> Finch.request(__MODULE__)
  end
end
