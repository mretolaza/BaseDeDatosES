defmodule ESalud.Diagnostic_PatientController do
  use ESalud.Web, :controller

  alias ESalud.Diagnostic_Patient

  def index(conn, _params) do
    diagnostic_patients = Repo.all(Diagnostic_Patient)
    render(conn, "index.json", diagnostic_patients: diagnostic_patients)
  end

  def create(conn, %{"diagnostic__patient" => diagnostic__patient_params}) do
    changeset = Diagnostic_Patient.changeset(%Diagnostic_Patient{}, diagnostic__patient_params)

    case Repo.insert(changeset) do
      {:ok, diagnostic__patient} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", diagnostic__patient_path(conn, :show, diagnostic__patient))
        |> render("show.json", diagnostic__patient: diagnostic__patient)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    diagnostic__patient = Repo.get!(Diagnostic_Patient, id)
    render(conn, "show.json", diagnostic__patient: diagnostic__patient)
  end

  def update(conn, %{"id" => id, "diagnostic__patient" => diagnostic__patient_params}) do
    diagnostic__patient = Repo.get!(Diagnostic_Patient, id)
    changeset = Diagnostic_Patient.changeset(diagnostic__patient, diagnostic__patient_params)

    case Repo.update(changeset) do
      {:ok, diagnostic__patient} ->
        render(conn, "show.json", diagnostic__patient: diagnostic__patient)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    diagnostic__patient = Repo.get!(Diagnostic_Patient, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(diagnostic__patient)

    send_resp(conn, :no_content, "")
  end
end
