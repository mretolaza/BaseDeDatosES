defmodule ESalud.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string
      add :address, :string
      add :weight, :float
      add :bloodType, :string
      add :birthDate, :date

      timestamps()
    end

  end
end
