defmodule Weather.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:Locations) do
      add :name, :string
      add :temp, :decimal
      add :pressure, :integer
      add :humidity, :integer
      add :windspeed, :decimal
      add :winddeg, :decimal

      timestamps()
    end
  end
end
