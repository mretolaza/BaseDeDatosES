defmodule ESalud.Diagnostic_DiseaseTest do
  use ESalud.ModelCase

  alias ESalud.Diagnostic_Disease

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Diagnostic_Disease.changeset(%Diagnostic_Disease{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Diagnostic_Disease.changeset(%Diagnostic_Disease{}, @invalid_attrs)
    refute changeset.valid?
  end
end
