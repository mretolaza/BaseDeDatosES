defmodule ESalud.DiseaseControllerTest do
  use ESalud.ConnCase

  alias ESalud.Disease
  @valid_attrs %{description: "some content", id_med: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, disease_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = get conn, disease_path(conn, :show, disease)
    assert json_response(conn, 200)["data"] == %{"id" => disease.id,
      "description" => disease.description,
      "id_med" => disease.id_med,
      "name" => disease.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, disease_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, disease_path(conn, :create), disease: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Disease, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, disease_path(conn, :create), disease: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = put conn, disease_path(conn, :update, disease), disease: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Disease, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = put conn, disease_path(conn, :update, disease), disease: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    disease = Repo.insert! %Disease{}
    conn = delete conn, disease_path(conn, :delete, disease)
    assert response(conn, 204)
    refute Repo.get(Disease, disease.id)
  end
end
