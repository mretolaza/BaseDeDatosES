defmodule ESalud.PatientsController do
  use ESalud.Web, :controller

  alias ESalud.Patients

  def index(conn, _params) do
    patients = Repo.all(Patients)
    render(conn, "index.json", patients: patients)
  end

  def create(conn, %{"patients" => patients_params}) do
    changeset = Patients.changeset(%Patients{}, patients_params)

    case Repo.insert(changeset) do
      {:ok, patients} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", patients_path(conn, :show, patients))
        |> render("show.json", patients: patients)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patients = Repo.get!(Patients, id)
    render(conn, "show.json", patients: patients)
  end

  def update(conn, %{"id" => id, "patients" => patients_params}) do
    patients = Repo.get!(Patients, id)
    changeset = Patients.changeset(patients, patients_params)

    case Repo.update(changeset) do
      {:ok, patients} ->
        render(conn, "show.json", patients: patients)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patients = Repo.get!(Patients, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(patients)

    send_resp(conn, :no_content, "")
  end
end
