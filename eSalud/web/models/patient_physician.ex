defmodule ESalud.PatientPhysician do
  use ESalud.Web, :model

  schema "patient_physicians" do
    belongs_to :patient, ESalud.Patient
    belongs_to :physician, ESalud.Physician

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
