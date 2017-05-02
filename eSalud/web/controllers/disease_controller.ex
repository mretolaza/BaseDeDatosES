defmodule ESalud.DiseaseController do
  use ESalud.Web, :controller

  alias ESalud.Disease

  def index(conn, _params) do
    disease = Repo.all(Disease)
    render(conn, "index.json", disease: disease)
  end

  def create(conn, %{"disease" => disease_params}) do
    changeset = Disease.changeset(%Disease{}, disease_params)

    case Repo.insert(changeset) do
      {:ok, disease} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", disease_path(conn, :show, disease))
        |> render("show.json", disease: disease)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    disease = Repo.get!(Disease, id)
    render(conn, "show.json", disease: disease)
  end

  def update(conn, %{"id" => id, "disease" => disease_params}) do
    disease = Repo.get!(Disease, id)
    changeset = Disease.changeset(disease, disease_params)

    case Repo.update(changeset) do
      {:ok, disease} ->
        render(conn, "show.json", disease: disease)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    disease = Repo.get!(Disease, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(disease)

    send_resp(conn, :no_content, "")
  end
end
