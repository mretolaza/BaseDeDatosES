defmodule ESalud.Diagnostic_DiseaseController do
  use ESalud.Web, :controller

  alias ESalud.Diagnostic_Disease

  def index(conn, _params) do
    diagnostic_disease = Repo.all(Diagnostic_Disease)
    render(conn, "index.json", diagnostic_disease: diagnostic_disease)
  end

  def create(conn, %{"diagnostic__disease" => diagnostic__disease_params}) do
    changeset = Diagnostic_Disease.changeset(%Diagnostic_Disease{}, diagnostic__disease_params)

    case Repo.insert(changeset) do
      {:ok, diagnostic__disease} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", diagnostic__disease_path(conn, :show, diagnostic__disease))
        |> render("show.json", diagnostic__disease: diagnostic__disease)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    diagnostic__disease = Repo.get!(Diagnostic_Disease, id)
    render(conn, "show.json", diagnostic__disease: diagnostic__disease)
  end

  def update(conn, %{"id" => id, "diagnostic__disease" => diagnostic__disease_params}) do
    diagnostic__disease = Repo.get!(Diagnostic_Disease, id)
    changeset = Diagnostic_Disease.changeset(diagnostic__disease, diagnostic__disease_params)

    case Repo.update(changeset) do
      {:ok, diagnostic__disease} ->
        render(conn, "show.json", diagnostic__disease: diagnostic__disease)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    diagnostic__disease = Repo.get!(Diagnostic_Disease, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(diagnostic__disease)

    send_resp(conn, :no_content, "")
  end
end
