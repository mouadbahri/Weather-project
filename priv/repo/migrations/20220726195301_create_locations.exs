defmodule Weather.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:Location) do
      add :name, :string
      add :temp, :decimal
      add :pressure, :integer
      add :humidity, :integer
      add :windspeed, :decimal
      add :winddeg, :decimal
    end
  end
end
