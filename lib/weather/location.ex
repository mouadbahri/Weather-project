defmodule Weather.Location do
  use Ecto.Schema

  schema "Locations" do
    field :name, :string
    field :temp, :decimal
    field :pressure, :integer
    field :humidity, :integer
    field :windspeed, :decimal
    field :winddeg, :decimal
    timestamps(type: :utc_datetime, default: DateTime.utc_now())
  end

  def changeset(location, params \\ %{}) do
    location
    |> Ecto.Changeset.cast(params, [:temp, :pressure, :humidity, :windspeed, :winddeg])
    |> Weather.Repo.insert()
  end

  def fields do
    __MODULE__.__schema__(:fields)
  end
end
