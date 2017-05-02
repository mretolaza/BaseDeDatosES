defmodule ESalud.Repo.Migrations.CreateDiagnostic_Patient do
  use Ecto.Migration

  def change do
    create table(:diagnostic_patients) do
      add :patient_id, references(:patients, on_delete: :nothing)
      add :diagnostic_id, references(:diagnostics, on_delete: :nothing)

      timestamps()
    end
    create index(:diagnostic_patients, [:patient_id])
    create index(:diagnostic_patients, [:diagnostic_id])

  end
end
