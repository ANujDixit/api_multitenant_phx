defmodule ApiEvalutoWeb.AuthenticationController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.Tenant

  action_fallback ApiEvalutoWeb.FallbackController

  def create(conn, %{"tenant" => tenant_params}) do
    with {:ok, %Tenant{} = tenant} <- Accounts.create_tenant(tenant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tenant_path(conn, :show, tenant))
      |> render("show.json", tenant: tenant)
    end
  end
  
end
