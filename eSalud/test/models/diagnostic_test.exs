defmodule ESalud.DiagnosticTest do
  use ESalud.ModelCase

  alias ESalud.Diagnostic

  @valid_attrs %{description: "some content", treatment: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Diagnostic.changeset(%Diagnostic{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Diagnostic.changeset(%Diagnostic{}, @invalid_attrs)
    refute changeset.valid?
  end
end
