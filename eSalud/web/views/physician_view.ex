defmodule ESalud.PhysicianView do
  use ESalud.Web, :view

  def render("index.json", %{physicians: physicians}) do
    %{data: render_many(physicians, ESalud.PhysicianView, "physician.json")}
  end

  def render("show.json", %{physician: physician}) do
    %{data: render_one(physician, ESalud.PhysicianView, "physician.json")}
  end

  def render("physician.json", %{physician: physician}) do
    %{id: physician.id,
      name: physician.name}
  end
end
