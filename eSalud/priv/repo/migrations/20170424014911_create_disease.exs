defmodule ESalud.Repo.Migrations.CreateDisease do
  use Ecto.Migration

  def change do
    create table(:disease) do
      add :description, :string
      add :id_med, :string
      add :name, :string

      timestamps()
    end

  end
end
