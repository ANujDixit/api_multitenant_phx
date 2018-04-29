defmodule ApiEvalutoWeb.AuthenticationView do
  use ApiEvalutoWeb, :view  

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
  
end
