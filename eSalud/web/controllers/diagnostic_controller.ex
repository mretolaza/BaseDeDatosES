defmodule ESalud.DiagnosticController do
  use ESalud.Web, :controller

  alias ESalud.Diagnostic

  def index(conn, _params) do
    diagnostics = Repo.all(Diagnostic)
    render(conn, "index.json", diagnostics: diagnostics)
  end

  def create(conn, %{"diagnostic" => diagnostic_params}) do
    changeset = Diagnostic.changeset(%Diagnostic{}, diagnostic_params)

    case Repo.insert(changeset) do
      {:ok, diagnostic} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", diagnostic_path(conn, :show, diagnostic))
        |> render("show.json", diagnostic: diagnostic)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    diagnostic = Repo.get!(Diagnostic, id)
    render(conn, "show.json", diagnostic: diagnostic)
  end

  def update(conn, %{"id" => id, "diagnostic" => diagnostic_params}) do
    diagnostic = Repo.get!(Diagnostic, id)
    changeset = Diagnostic.changeset(diagnostic, diagnostic_params)

    case Repo.update(changeset) do
      {:ok, diagnostic} ->
        render(conn, "show.json", diagnostic: diagnostic)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ESalud.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    diagnostic = Repo.get!(Diagnostic, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(diagnostic)

    send_resp(conn, :no_content, "")
  end
end
