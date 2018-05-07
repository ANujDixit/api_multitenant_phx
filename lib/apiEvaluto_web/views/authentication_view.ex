defmodule ApiEvalutoWeb.AuthenticationView do
  use ApiEvalutoWeb, :view  

  def render("jwt.json", %{jwt: jwt, tenant: tenant, credential: credential}) do
    user = credential.user
    %{data: %{jwt: jwt, 
              tenant: %{id: tenant.id, code: tenant.code, slug: tenant.slug, name: tenant.name},
              user: %{id: user.id, first_name: user.first_name, last_name: user.last_name, email: credential.email,
                      role: user.role.name} }}
  end
  
end
