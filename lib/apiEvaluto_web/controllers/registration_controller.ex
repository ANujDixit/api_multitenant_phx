defmodule ApiEvalutoWeb.RegistrationController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.Tenant

  action_fallback ApiEvalutoWeb.FallbackController

  def create(conn, %{"registration" => registration_params}) do
    with  {:ok, %Tenant{} = tenant} <- Accounts.register(registration_params),
          {:ok, token, _claims} <- Guardian.encode_and_sign(tenant) do
            conn |> render("jwt.json", jwt: token)
    end    
  end
  
end
