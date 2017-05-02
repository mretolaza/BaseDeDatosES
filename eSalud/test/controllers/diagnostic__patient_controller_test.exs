defmodule ESalud.Diagnostic_PatientControllerTest do
  use ESalud.ConnCase

  alias ESalud.Diagnostic_Patient
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, diagnostic__patient_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    diagnostic__patient = Repo.insert! %Diagnostic_Patient{}
    conn = get conn, diagnostic__patient_path(conn, :show, diagnostic__patient)
    assert json_response(conn, 200)["data"] == %{"id" => diagnostic__patient.id,
      "patient_id" => diagnostic__patient.patient_id,
      "diagnostic_id" => diagnostic__patient.diagnostic_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, diagnostic__patient_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, diagnostic__patient_path(conn, :create), diagnostic__patient: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Diagnostic_Patient, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, diagnostic__patient_path(conn, :create), diagnostic__patient: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    diagnostic__patient = Repo.insert! %Diagnostic_Patient{}
    conn = put conn, diagnostic__patient_path(conn, :update, diagnostic__patient), diagnostic__patient: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Diagnostic_Patient, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    diagnostic__patient = Repo.insert! %Diagnostic_Patient{}
    conn = put conn, diagnostic__patient_path(conn, :update, diagnostic__patient), diagnostic__patient: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    diagnostic__patient = Repo.insert! %Diagnostic_Patient{}
    conn = delete conn, diagnostic__patient_path(conn, :delete, diagnostic__patient)
    assert response(conn, 204)
    refute Repo.get(Diagnostic_Patient, diagnostic__patient.id)
  end
end
