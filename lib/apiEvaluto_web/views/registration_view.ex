defmodule ApiEvalutoWeb.RegistrationView do
  use ApiEvalutoWeb, :view  

  def render("show.json", %{message: msg, title: title}) do
    %{data: %{message: msg, title: title}}
  end 
  
  def render("verify_tenant.json", %{tenant: tenant}) do
    %{data: %{verified: tenant.verified}}
  end
  
end
