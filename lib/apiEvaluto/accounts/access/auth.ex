defmodule ApiEvaluto.Accounts.Access.Auth do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      import Comeonin.Bcrypt, only: [checkpw: 2]         
      alias ApiEvaluto.Accounts 

      def verify_password(password, password_hash) when is_binary(password) and is_binary(password_hash)  do
        if checkpw(password, password_hash) do
          {:ok}
        else
          {:error, :invalid_password}
        end
      end

      def verify_password(_, _) do
        {:error, :invalid_password}
      end  
        
    end
  end
end