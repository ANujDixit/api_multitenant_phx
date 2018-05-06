defmodule ApiEvalutoWeb.RegistrationView do
  use ApiEvalutoWeb, :view  

  def render("show.json", %{registration_success_status: status}) do
    %{data: %{registration_success_status: status}}
  end 
  
  def render("verify_tenant.json", %{tenant: tenant}) do
    %{data: %{verified: tenant.verified}}
  end
  
end
