defmodule Weather.Day do
  use Ecto.Schema

  schema "days" do
    field :location, :string
    field :lat, :integer
    field :lon, :integer
    field :temp, :integer
    field :presure, :integer
    field :humidity, :integer
    field :windspeed, :integer
    field :winddeg, :integer
    field :weather, :string
    field :weatherid, :integer
  end

  def changeset(day, params \\ %{}) do
    day
    |> Ecto.Changeset.cast(params, [:location, :locationid, :lat, :lon, :temp, :presure, :humidity, :windspeed, :winddeg, :weather, :weatherid])
    |> Ecto.Changeset.validate_required([:location])
  end
end
