defmodule Weather.Repo.Migrations.CreateDays do
  use Ecto.Migration

  def change do
    create table(:days) do
      add :temp, :integer
      add :pressure, :integer
      add :humidity, :integer
      add :windspeed, :integer
      add :winddeg, :integer
    #  add :description, :string
    end
  end
end
