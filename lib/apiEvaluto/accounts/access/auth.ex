defmodule ApiEvaluto.Accounts.Access.Auth do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo
      
      def token_sign_in(tenant, email, password) do
        case email_password_auth(tenant, email, password) do
          {:ok, user} ->  
            Guardian.encode_and_sign(user)
          _ ->
            {:error, :unauthorized}
        end
      end
    
      defp email_password_auth(tenant, email, password) when is_binary(email) and is_binary(password) do
        with {:ok, user} <- get_by_email(email),
        do: verify_password(password, user)
      end
    
      defp get_by_email(email) when is_binary(email) do
        case Repo.get_by(Credential, email: email) do
          nil ->
            dummy_checkpw()
            {:error, "Login error."}
          user ->
            {:ok, user}
        end
      end
    
      defp verify_password(password, %User{} = user) when is_binary(password) do
        if checkpw(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_password}
        end
      end
        
    end
  end
end