defmodule ESalud.PhysicianTest do
  use ESalud.ModelCase

  alias ESalud.Physician

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Physician.changeset(%Physician{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Physician.changeset(%Physician{}, @invalid_attrs)
    refute changeset.valid?
  end
end
