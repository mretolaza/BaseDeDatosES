defmodule ESalud.PatientPhysicianController do
  use ESalud.Web, :controller

  alias ESalud.PatientPhysician

  def index(conn, _params) do
    patient_physicians = Repo.all(PatientPhysician)
    render(conn, "index.json", patient_physicians: patient_physicians)
  end

  def create(conn, %{"patient_physician" => patient_physician_params}) do
    changeset = PatientPhysician.changeset(%PatientPhysician{}, patient_physician_params)

    case Repo.insert(changeset) do
      {:ok, patient_physician} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", patient_physician_path(conn, :show, patient_physician))
        |> render("show.json", patient_physician: patient_physician)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient_physician = Repo.get!(PatientPhysician, id)
    render(conn, "show.json", patient_physician: patient_physician)
  end

  def update(conn, %{"id" => id, "patient_physician" => patient_physician_params}) do
    patient_physician = Repo.get!(PatientPhysician, id)
    changeset = PatientPhysician.changeset(patient_physician, patient_physician_params)

    case Repo.update(changeset) do
      {:ok, patient_physician} ->
        render(conn, "show.json", patient_physician: patient_physician)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient_physician = Repo.get!(PatientPhysician, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(patient_physician)

    send_resp(conn, :no_content, "")
  end
end
