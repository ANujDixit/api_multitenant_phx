defmodule ApiEvalutoWeb.RegistrationView do
  use ApiEvalutoWeb, :view  

  def render("jwt.json", %{jwt: jwt}) do    
    %{data: %{jwt: jwt}}
  end
  
  def render("verify_tenant.json", %{tenant: tenant}) do
    %{data: %{verified: tenant.verified }}
  end
  
end
