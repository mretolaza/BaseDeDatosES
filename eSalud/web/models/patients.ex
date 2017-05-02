defmodule ESalud.Patients do
  use ESalud.Web, :model

  schema "patients" do
    field :name, :string
    field :address, :string
    field :weight, :float
    field :bloodType, :string
    field :birthDate, Ecto.Date

    many_to_many :physician, ESalud.Physician, join_through: ESalud.PatientPhysician
    many_to_many :diagnostic, ESalud.Diagnostic, join_through: ESalud.Diagnostic_Patient
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :weight, :bloodType, :birthDate])
    |> validate_required([:name, :address, :weight, :bloodType, :birthDate])
  end
end
