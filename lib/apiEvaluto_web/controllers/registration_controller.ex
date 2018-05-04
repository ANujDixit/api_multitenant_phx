defmodule ApiEvalutoWeb.RegistrationController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Guardian 
  alias ApiEvaluto.{Accounts, Notifications}
  alias ApiEvaluto.Accounts.{Tenant, User, Credential}  
  alias ApiEvaluto.Auth.Token

  action_fallback ApiEvalutoWeb.FallbackController 

  def create(conn, %{"registration" => registration_params}) do
    with  {:ok, %Tenant{} = tenant, %User{} = user, %Credential{} = credential} <- Accounts.register(registration_params),
          {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{tenant_slug: tenant.slug, tenant_code: tenant.code}) do
          
            tenant_verification_url = registration_url(conn, :verify_tenant, token: Token.generate_new_account_token(user))
            Notifications.send_admin_account_verification_email("#{user.first_name} #{user.last_name}", 
                                                                 tenant.name,
                                                                 credential.email, 
                                                                 tenant_verification_url)                                                   
            render(conn, "jwt.json", jwt: token)
            
    else 
      {:error, changeset} -> {:error, changeset}
      _ -> {:error, :guardian_token_issue} 
    end    
  end
  
  def verify_tenant(conn, %{"token" => token}) do
    with {:ok, %Tenant{} = tenant, %User{} = user}  <- Token.verify_new_account_token(token) do
         case Accounts.verify_tenant(tenant, user) do
          {:ok, tenant} ->
            conn
            |> put_status(200)
            |> render("verify_tenant.json", tenant: tenant)
          {:error, _} ->
            conn
            |> put_status(:not_found)
            |> json(%{error: "invalid token"})
         end
    end
  end
  
end
