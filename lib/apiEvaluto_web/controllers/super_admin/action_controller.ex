defmodule ApiEvalutoWeb.ActionController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Authorization
  alias ApiEvaluto.Authorization.Action

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    actions = Authorization.list_actions()
    render(conn, "index.json", actions: actions)
  end

  def create(conn, %{"action" => action_params}) do
    with {:ok, %Action{} = action} <- Authorization.create_action(action_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", action_path(conn, :show, action))
      |> render("show.json", action: action)
    end
  end

  def show(conn, %{"id" => id}) do
    action = Authorization.get_action!(id)
    render(conn, "show.json", action: action)
  end

  def update(conn, %{"id" => id, "action" => action_params}) do
    action = Authorization.get_action!(id)

    with {:ok, %Action{} = action} <- Authorization.update_action(action, action_params) do
      render(conn, "show.json", action: action)
    end
  end

  def delete(conn, %{"id" => id}) do
    action = Authorization.get_action!(id)
    with {:ok, %Action{}} <- Authorization.delete_action(action) do
      send_resp(conn, :no_content, "")
    end
  end
end
