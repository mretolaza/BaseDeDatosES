defmodule ESalud.DiagnosticControllerTest do
  use ESalud.ConnCase

  alias ESalud.Diagnostic
  @valid_attrs %{description: "some content", treatment: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, diagnostic_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    diagnostic = Repo.insert! %Diagnostic{}
    conn = get conn, diagnostic_path(conn, :show, diagnostic)
    assert json_response(conn, 200)["data"] == %{"id" => diagnostic.id,
      "description" => diagnostic.description,
      "treatment" => diagnostic.treatment}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, diagnostic_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, diagnostic_path(conn, :create), diagnostic: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Diagnostic, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, diagnostic_path(conn, :create), diagnostic: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    diagnostic = Repo.insert! %Diagnostic{}
    conn = put conn, diagnostic_path(conn, :update, diagnostic), diagnostic: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Diagnostic, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    diagnostic = Repo.insert! %Diagnostic{}
    conn = put conn, diagnostic_path(conn, :update, diagnostic), diagnostic: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    diagnostic = Repo.insert! %Diagnostic{}
    conn = delete conn, diagnostic_path(conn, :delete, diagnostic)
    assert response(conn, 204)
    refute Repo.get(Diagnostic, diagnostic.id)
  end
end
