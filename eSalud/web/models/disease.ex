defmodule ESalud.Disease do
  use ESalud.Web, :model

  schema "disease" do
    field :description, :string
    field :id_med, :string
    field :name, :string


    many_to_many :diagnostic, ESalud.Diagnostic, join_through: ESalud.Diagnostic_Disease
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :id_med, :name])
    |> validate_required([:description, :id_med, :name])
  end
end
