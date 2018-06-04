defmodule ApiEvalutoWeb.SuperAdmin.AuthenticationView do
  use ApiEvalutoWeb, :view  

  def render("jwt.json", %{jwt: jwt, user: user}) do
    %{data: %{jwt: jwt, 
              user: %{id: user.id, email: user.email, role: "SuperAdmin"} }}
  end
  
end
