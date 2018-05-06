defmodule ApiEvalutoWeb.AuthenticationView do
  use ApiEvalutoWeb, :view  

  def render("jwt.json", %{jwt: jwt}) do
    %{data: %{jwt: jwt}}
  end
  
end
