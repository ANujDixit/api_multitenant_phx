defmodule ApiEvalutoWeb.AuthenticationController do
  
  use ApiEvalutoWeb, :controller
  import Comeonin.Bcrypt, only: [dummy_checkpw: 0]
  alias ApiEvaluto.Guardian 
  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.{Tenant, Credential}

  action_fallback ApiEvalutoWeb.FallbackController

  def create(conn, %{"signin" => %{"email" => email, "password" => password, "tenant_code" => code} }) do
    with %Tenant{} = tenant         <- Accounts.get_tenant_by_code(code),
         %Credential{} = credential <- Accounts.get_credential_by_email(tenant, email),
         {:ok}                      <- Accounts.verify_password(password, credential.password_hash) do            

          case Guardian.encode_and_sign(credential.user, %{tenant_id: tenant.id}) do
            {:ok, token, _claims} ->
              conn |> render("jwt.json", jwt: token, tenant: tenant, credential: credential)
            _ ->
              {:error, {:unauthorized, msg: "Token encode issue"}}
          end        
    else 
      _ -> dummy_checkpw() 
           {:error, {:unauthorized, msg: "Tenant not found"}}
      _ -> dummy_checkpw() 
           {:error, {:unauthorized, msg: "User not found in Tenant"}}
      _ -> {:error, {:unauthorized, msg: "Invalid Password"}}     
    end
  end
  
end
