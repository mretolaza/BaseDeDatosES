defmodule ESalud.PatientsView do
  use ESalud.Web, :view

  def render("index.json", %{patients: patients}) do
    %{data: render_many(patients, ESalud.PatientsView, "patients.json")}
  end

  def render("show.json", %{patients: patients}) do
    %{data: render_one(patients, ESalud.PatientsView, "patients.json")}
  end

  def render("patients.json", %{patients: patients}) do
    %{id: patients.id,
      name: patients.name,
      address: patients.address,
      weight: patients.weight,
      bloodType: patients.bloodType,
      birthDate: patients.birthDate}
  end
end
