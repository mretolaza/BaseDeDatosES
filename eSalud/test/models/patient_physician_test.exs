defmodule ESalud.PatientPhysicianTest do
  use ESalud.ModelCase

  alias ESalud.PatientPhysician

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PatientPhysician.changeset(%PatientPhysician{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PatientPhysician.changeset(%PatientPhysician{}, @invalid_attrs)
    refute changeset.valid?
  end
end
