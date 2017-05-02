defmodule ESalud.Diagnostic_PatientTest do
  use ESalud.ModelCase

  alias ESalud.Diagnostic_Patient

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Diagnostic_Patient.changeset(%Diagnostic_Patient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Diagnostic_Patient.changeset(%Diagnostic_Patient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
