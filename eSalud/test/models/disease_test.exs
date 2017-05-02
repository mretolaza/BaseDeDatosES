defmodule ESalud.DiseaseTest do
  use ESalud.ModelCase

  alias ESalud.Disease

  @valid_attrs %{description: "some content", id_med: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Disease.changeset(%Disease{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Disease.changeset(%Disease{}, @invalid_attrs)
    refute changeset.valid?
  end
end
