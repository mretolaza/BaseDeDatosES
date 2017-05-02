defmodule ESalud.Repo.Migrations.CreatePhysician do
  use Ecto.Migration

  def change do
    create table(:physicians) do
      add :name, :string

      timestamps()
    end

  end
end
