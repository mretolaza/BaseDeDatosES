defmodule ESalud.Diagnostic_PatientView do
  use ESalud.Web, :view

  def render("index.json", %{diagnostic_patients: diagnostic_patients}) do
    %{data: render_many(diagnostic_patients, ESalud.Diagnostic_PatientView, "diagnostic__patient.json")}
  end

  def render("show.json", %{diagnostic__patient: diagnostic__patient}) do
    %{data: render_one(diagnostic__patient, ESalud.Diagnostic_PatientView, "diagnostic__patient.json")}
  end

  def render("diagnostic__patient.json", %{diagnostic__patient: diagnostic__patient}) do
    %{id: diagnostic__patient.id,
      patient_id: diagnostic__patient.patient_id,
      diagnostic_id: diagnostic__patient.diagnostic_id}
  end
end
