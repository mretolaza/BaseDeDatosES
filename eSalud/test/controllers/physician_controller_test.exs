defmodule ESalud.PhysicianControllerTest do
  use ESalud.ConnCase

  alias ESalud.Physician
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, physician_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    physician = Repo.insert! %Physician{}
    conn = get conn, physician_path(conn, :show, physician)
    assert json_response(conn, 200)["data"] == %{"id" => physician.id,
      "name" => physician.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, physician_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, physician_path(conn, :create), physician: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Physician, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, physician_path(conn, :create), physician: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    physician = Repo.insert! %Physician{}
    conn = put conn, physician_path(conn, :update, physician), physician: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Physician, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    physician = Repo.insert! %Physician{}
    conn = put conn, physician_path(conn, :update, physician), physician: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    physician = Repo.insert! %Physician{}
    conn = delete conn, physician_path(conn, :delete, physician)
    assert response(conn, 204)
    refute Repo.get(Physician, physician.id)
  end
end
