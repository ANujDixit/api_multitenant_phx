defmodule ApiEvalutoWeb.Admin.RoleController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Authorization
  alias ApiEvaluto.Authorization.Role

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    roles = Authorization.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- Authorization.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Authorization.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Authorization.get_role!(id)

    with {:ok, %Role{} = role} <- Authorization.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Authorization.get_role!(id)
    with {:ok, %Role{}} <- Authorization.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
