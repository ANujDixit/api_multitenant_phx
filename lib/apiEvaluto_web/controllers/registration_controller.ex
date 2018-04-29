defmodule ApiEvalutoWeb.RegistrationController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Guardian 
  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.{Tenant, User}  

  action_fallback ApiEvalutoWeb.FallbackController 

  def create(conn, %{"registration" => registration_params}) do
    with  {:ok, %Tenant{} = tenant, %User{} = user} <- Accounts.register(registration_params),
          {:ok, token, _claims} <- Guardian.encode_and_sign(user, 
                                                           %{tenant_slug: tenant.slug, 
                                                             tenant_code: tenant.code}) do
            conn |> render("jwt.json", jwt: token)
    end    
  end
  
end
