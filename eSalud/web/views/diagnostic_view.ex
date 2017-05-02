defmodule ESalud.DiagnosticView do
  use ESalud.Web, :view

  def render("index.json", %{diagnostics: diagnostics}) do
    %{data: render_many(diagnostics, ESalud.DiagnosticView, "diagnostic.json")}
  end

  def render("show.json", %{diagnostic: diagnostic}) do
    %{data: render_one(diagnostic, ESalud.DiagnosticView, "diagnostic.json")}
  end

  def render("diagnostic.json", %{diagnostic: diagnostic}) do
    %{id: diagnostic.id,
      description: diagnostic.description,
      treatment: diagnostic.treatment}
  end
end
