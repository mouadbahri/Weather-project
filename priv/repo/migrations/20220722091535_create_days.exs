defmodule Weather.Repo.Migrations.CreateDays do
  use Ecto.Migration

  def change do
    create table(:days) do
      add :name, :string
      add :lat, :integer
      add :lon, :integer
      add :temp, :integer
      add :presure, :integer
      add :humidity, :integer
      add :windspeed, :integer
      add :winddeg, :integer
      add :weather, :string
      add :weatherid, :integer
    end
  end
end
