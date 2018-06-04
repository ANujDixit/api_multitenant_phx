defmodule ApiEvalutoWeb.SuperAdmin.AuthenticationController do
  
  use ApiEvalutoWeb, :controller
  import Comeonin.Bcrypt, only: [dummy_checkpw: 0]
  alias ApiEvaluto.Guardian 
  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.AdminUser

  action_fallback ApiEvalutoWeb.FallbackController

  def create(conn, %{"signin" => %{"email" => email, "password" => password } }) do
    with %AdminUser{} = admin_user <- Accounts.get_admin_user_by_email(email),
         {:ok}                     <- Accounts.verify_password(password, admin_user.password_hash) do  
         
          case Guardian.encode_and_sign(admin_user) do
            {:ok, token, _claims} ->
              conn |> render("jwt.json", jwt: token, user: admin_user)
            _ ->
              {:error, {:unauthorized, msg: "Token encode issue"}}
          end        
    else 
      {:error, :admin_user_not_found} -> 
            dummy_checkpw() 
            {:error, {:unauthorized, msg: "Admin User not found"}}
      {:error, :invalid_password} -> 
            {:error, {:unauthorized, msg: "Invalid Password"}}   
    end        
  end
  
end
