defmodule ApiEvalutoWeb.RegistrationView do
  use ApiEvalutoWeb, :view  

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
  
  def render("verify_tenant.json", %{tenant: tenant}) do
      %{
          verified: tenant.verified
      }   
  end
  
end
