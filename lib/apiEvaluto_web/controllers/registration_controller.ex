defmodule ApiEvalutoWeb.RegistrationController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Guardian 
  alias ApiEvaluto.{Accounts, Notifications}
  alias ApiEvaluto.Accounts.{Tenant, User, Credential}  
  alias ApiEvaluto.Auth.Token

  action_fallback ApiEvalutoWeb.FallbackController 

  def create(conn, %{"signup" => signup_params}) do
    with  {:ok, %Tenant{} = tenant, %User{} = user, %Credential{} = credential} <- Accounts.register(signup_params) do
          
            tenant_verification_url = 
              registration_url(conn, :verify_tenant, token: Token.generate_new_account_token(user))
              |> String.replace("8080/api", "4200/admin-portal")

            Notifications.send_admin_account_verification_email( user.first_name, 
                                                                 credential.email,  
                                                                 tenant.name,  
                                                                 tenant.code,                                                              
                                                                 tenant_verification_url)                                                   
            conn
            |> put_status(:created)      
            |> render("show.json", registration_success_status: true)            
    else 
      {:error, changeset} -> {:error, changeset}
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
