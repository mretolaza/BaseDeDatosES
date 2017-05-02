defmodule ESalud.PatientPhysicianView do
  use ESalud.Web, :view

  def render("index.json", %{patient_physicians: patient_physicians}) do
    %{data: render_many(patient_physicians, ESalud.PatientPhysicianView, "patient_physician.json")}
  end

  def render("show.json", %{patient_physician: patient_physician}) do
    %{data: render_one(patient_physician, ESalud.PatientPhysicianView, "patient_physician.json")}
  end

  def render("patient_physician.json", %{patient_physician: patient_physician}) do
    %{id: patient_physician.id,
      patient_id: patient_physician.patient_id,
      physician_id: patient_physician.physician_id}
  end
end
