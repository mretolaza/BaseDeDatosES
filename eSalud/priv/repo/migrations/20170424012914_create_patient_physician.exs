defmodule ESalud.Repo.Migrations.CreatePatientPhysician do
  use Ecto.Migration

  def change do
    create table(:patient_physicians) do
      add :patient_id, references(:patients, on_delete: :nothing)
      add :physician_id, references(:physicians, on_delete: :nothing)

      timestamps()
    end
    create index(:patient_physicians, [:patient_id])
    create index(:patient_physicians, [:physician_id])

  end
end
