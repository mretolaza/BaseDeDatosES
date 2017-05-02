defmodule ESalud.Diagnostic_Patient do
  use ESalud.Web, :model

  schema "diagnostic_patients" do
    belongs_to :patient, ESalud.Patient
    belongs_to :diagnostic, ESalud.Diagnostic

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
