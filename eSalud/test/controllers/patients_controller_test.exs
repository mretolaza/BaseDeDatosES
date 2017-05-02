defmodule ESalud.PatientsControllerTest do
  use ESalud.ConnCase

  alias ESalud.Patients
  @valid_attrs %{address: "some content", birthDate: %{day: 17, month: 4, year: 2010}, bloodType: "some content", name: "some content", weight: "120.5"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, patients_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    patients = Repo.insert! %Patients{}
    conn = get conn, patients_path(conn, :show, patients)
    assert json_response(conn, 200)["data"] == %{"id" => patients.id,
      "name" => patients.name,
      "address" => patients.address,
      "weight" => patients.weight,
      "bloodType" => patients.bloodType,
      "birthDate" => patients.birthDate}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, patients_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, patients_path(conn, :create), patients: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Patients, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, patients_path(conn, :create), patients: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    patients = Repo.insert! %Patients{}
    conn = put conn, patients_path(conn, :update, patients), patients: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Patients, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    patients = Repo.insert! %Patients{}
    conn = put conn, patients_path(conn, :update, patients), patients: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    patients = Repo.insert! %Patients{}
    conn = delete conn, patients_path(conn, :delete, patients)
    assert response(conn, 204)
    refute Repo.get(Patients, patients.id)
  end
end
