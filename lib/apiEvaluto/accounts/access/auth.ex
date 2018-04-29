defmodule ApiEvaluto.Accounts.Access.Auth do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
      
      alias ApiEvaluto.Repo
      alias ApiEvaluto.Guardian   
      alias ApiEvaluto.Accounts
      alias ApiEvaluto.Accounts.{User, Credential}
      
      def token_sign_in(tenant, email, password) do
        case email_password_auth(tenant, email, password) do
          {:ok, user} ->  
            Guardian.encode_and_sign(user, %{tenant_slug: tenant.slug, tenant_code: tenant.code})
          _ ->
            {:error, :unauthorized}
        end
      end
    
      defp email_password_auth(tenant, email, password) when not is_nil(tenant) and is_binary(email) and is_binary(password) do
        with {:ok, credential} <- get_by_email(tenant, email),
        do: verify_password(tenant, password, credential)
      end
    
      defp get_by_email(tenant, email) when not is_nil(tenant) and is_binary(email) do
        case Repo.get_by(Credential, [tenant_id: tenant.id, email: email]) do
          nil ->
            dummy_checkpw()
            {:error, "Login error."}
          credential ->
            {:ok, credential}
        end
      end
    
      defp verify_password(tenant, password, %Credential{} = credential) when not is_nil(tenant) and is_binary(password) do
        if checkpw(password, credential.password_hash) do
          {:ok, Accounts.get_user!(tenant, credential.user_id)}
        else
          {:error, :invalid_password}
        end
      end
        
    end
  end
end