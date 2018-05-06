defmodule ApiEvalutoWeb.AuthenticationController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.{Accounts, Notifications}
  alias ApiEvaluto.Accounts.Tenant

  action_fallback ApiEvalutoWeb.FallbackController

  def create(conn, %{"signin" => %{"email" => email, "password" => password, "tenant_code" => code} }) do
    with %Tenant{} = tenant <- Accounts.get_tenant_by_code(code) do    
      case Accounts.token_sign_in(tenant, email, password) do
        {:ok, token, _claims} ->
          conn |> render("jwt.json", jwt: token)
        _ ->
          {:error, :unauthorized}
      end
    else 
      _ -> {:error, :tenant_not_found}
    end
  end
  
end
