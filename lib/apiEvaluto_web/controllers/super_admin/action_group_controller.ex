defmodule ApiEvalutoWeb.ActionGroupController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Authorization
  alias ApiEvaluto.Authorization.ActionGroup

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    action_groups = Authorization.list_action_groups()
    render(conn, "index.json", action_groups: action_groups)
  end

  def create(conn, %{"action_group" => action_group_params}) do
    with {:ok, %ActionGroup{} = action_group} <- Authorization.create_action_group(action_group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", action_group_path(conn, :show, action_group))
      |> render("show.json", action_group: action_group)
    end
  end

  def show(conn, %{"id" => id}) do
    action_group = Authorization.get_action_group!(id)
    render(conn, "show.json", action_group: action_group)
  end

  def update(conn, %{"id" => id, "action_group" => action_group_params}) do
    action_group = Authorization.get_action_group!(id)

    with {:ok, %ActionGroup{} = action_group} <- Authorization.update_action_group(action_group, action_group_params) do
      render(conn, "show.json", action_group: action_group)
    end
  end

  def delete(conn, %{"id" => id}) do
    action_group = Authorization.get_action_group!(id)
    with {:ok, %ActionGroup{}} <- Authorization.delete_action_group(action_group) do
      send_resp(conn, :no_content, "")
    end
  end
end
