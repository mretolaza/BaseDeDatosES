defmodule ESalud.PatientsTest do
  use ESalud.ModelCase

  alias ESalud.Patients

  @valid_attrs %{address: "some content", birthDate: %{day: 17, month: 4, year: 2010}, bloodType: "some content", name: "some content", weight: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Patients.changeset(%Patients{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Patients.changeset(%Patients{}, @invalid_attrs)
    refute changeset.valid?
  end
end
