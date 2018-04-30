defmodule ApiEvalutoWeb.Admin.GroupController do
  use ApiEvaluto.Controller

  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.Group  

  def index(conn, _params, resource) do
    groups = Accounts.list_groups(resource)
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params}, resource) do
    with {:ok, %Group{} = group} <- Accounts.create_group(resource, group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}, resource) do
    group = Accounts.get_group!(resource, id)
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}, resource) do
    group = Accounts.get_group!(resource, id)

    with {:ok, %Group{} = group} <- Accounts.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}, resource) do
    group = Accounts.get_group!(resource, id)
    with {:ok, %Group{}} <- Accounts.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
