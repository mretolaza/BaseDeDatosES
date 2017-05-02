defmodule ESalud.Repo.Migrations.CreateDiagnostic do
  use Ecto.Migration

  def change do
    create table(:diagnostics) do
      add :description, :string
      add :treatment, :string

      timestamps()
    end

  end
end
