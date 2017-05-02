defmodule ESalud.Diagnostic_DiseaseView do
  use ESalud.Web, :view

  def render("index.json", %{diagnostic_disease: diagnostic_disease}) do
    %{data: render_many(diagnostic_disease, ESalud.Diagnostic_DiseaseView, "diagnostic__disease.json")}
  end

  def render("show.json", %{diagnostic__disease: diagnostic__disease}) do
    %{data: render_one(diagnostic__disease, ESalud.Diagnostic_DiseaseView, "diagnostic__disease.json")}
  end

  def render("diagnostic__disease.json", %{diagnostic__disease: diagnostic__disease}) do
    %{id: diagnostic__disease.id,
      diagnostic_id: diagnostic__disease.diagnostic_id,
      disease_id: diagnostic__disease.disease_id}
  end
end
