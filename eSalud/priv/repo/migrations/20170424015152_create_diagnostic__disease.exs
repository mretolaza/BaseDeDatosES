defmodule ESalud.Repo.Migrations.CreateDiagnostic_Disease do
  use Ecto.Migration

  def change do
    create table(:diagnostic_disease) do
      add :diagnostic_id, references(:diagnostics, on_delete: :nothing)
      add :disease_id, references(:disease, on_delete: :nothing)

      timestamps()
    end
    create index(:diagnostic_disease, [:diagnostic_id])
    create index(:diagnostic_disease, [:disease_id])

  end
end
