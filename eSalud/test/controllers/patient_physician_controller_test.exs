defmodule ESalud.PatientPhysicianControllerTest do
  use ESalud.ConnCase

  alias ESalud.PatientPhysician
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, patient_physician_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    patient_physician = Repo.insert! %PatientPhysician{}
    conn = get conn, patient_physician_path(conn, :show, patient_physician)
    assert json_response(conn, 200)["data"] == %{"id" => patient_physician.id,
      "patient_id" => patient_physician.patient_id,
      "physician_id" => patient_physician.physician_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, patient_physician_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, patient_physician_path(conn, :create), patient_physician: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PatientPhysician, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, patient_physician_path(conn, :create), patient_physician: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    patient_physician = Repo.insert! %PatientPhysician{}
    conn = put conn, patient_physician_path(conn, :update, patient_physician), patient_physician: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PatientPhysician, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    patient_physician = Repo.insert! %PatientPhysician{}
    conn = put conn, patient_physician_path(conn, :update, patient_physician), patient_physician: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    patient_physician = Repo.insert! %PatientPhysician{}
    conn = delete conn, patient_physician_path(conn, :delete, patient_physician)
    assert response(conn, 204)
    refute Repo.get(PatientPhysician, patient_physician.id)
  end
end
