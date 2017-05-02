defmodule ESalud.Diagnostic_Disease do
  use ESalud.Web, :model

  schema "diagnostic_disease" do
    belongs_to :diagnostic, ESalud.Diagnostic
    belongs_to :disease, ESalud.Disease


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
