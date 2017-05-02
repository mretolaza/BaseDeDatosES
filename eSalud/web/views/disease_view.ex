defmodule ESalud.DiseaseView do
  use ESalud.Web, :view

  def render("index.json", %{disease: disease}) do
    %{data: render_many(disease, ESalud.DiseaseView, "disease.json")}
  end

  def render("show.json", %{disease: disease}) do
    %{data: render_one(disease, ESalud.DiseaseView, "disease.json")}
  end

  def render("disease.json", %{disease: disease}) do
    %{id: disease.id,
      description: disease.description,
      id_med: disease.id_med,
      name: disease.name}
  end
end
