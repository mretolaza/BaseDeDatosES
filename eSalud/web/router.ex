defmodule ESalud.Router do
  use ESalud.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ESalud do
    pipe_through :api
    
    resources "/physicians", PhysicianController, except: [:new, :edit]
    resources "/patients", PatientsController, except: [:new, :edit]
    resources "/patient_physicians", PatientPhysicianController, except: [:new, :edit]
    
    resources "/diagnostics", DiagnosticController, except: [:new, :edit]
    resources "/diagnostic_patients", Diagnostic_PatientController, except: [:new, :edit]
    resources "/disease", DiseaseController, except: [:new, :edit]
    resources "/diagnostic_disease", Diagnostic_DiseaseController, except: [:new, :edit]
  end
end
