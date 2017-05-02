defmodule ESalud.PhysicianController do
  use ESalud.Web, :controller

  alias ESalud.Physician

  def index(conn, _params) do
    physicians = Repo.all(Physician)
    render(conn, "index.json", physicians: physicians)
  end

  def create(conn, %{"physician" => physician_params}) do
    changeset = Physician.changeset(%Physician{}, physician_params)

    case Repo.insert(changeset) do
      {:ok, physician} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", physician_path(conn, :show, physician))
        |> render("show.json", physician: physician)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    physician = Repo.get!(Physician, id)
    render(conn, "show.json", physician: physician)
  end

  def update(conn, %{"id" => id, "physician" => physician_params}) do
    physician = Repo.get!(Physician, id)
    changeset = Physician.changeset(physician, physician_params)

    case Repo.update(changeset) do
      {:ok, physician} ->
        render(conn, "show.json", physician: physician)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    physician = Repo.get!(Physician, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(physician)

    send_resp(conn, :no_content, "")
  end
end
