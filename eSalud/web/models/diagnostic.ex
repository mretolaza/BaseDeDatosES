defmodule ESalud.Diagnostic do
  use ESalud.Web, :model

  schema "diagnostics" do
    field :description, :string
    field :treatment, :string

    many_to_many :patient, ESalud.Patient, join_through: ESalud.Diagnostic_Patient
    many_to_many :disease, ESalud.Disease, join_through: ESalud.Diagnostic_Disease
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :treatment])
    |> validate_required([:description, :treatment])
  end
end
