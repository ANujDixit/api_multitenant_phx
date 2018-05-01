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
    end    
  end
  
end
