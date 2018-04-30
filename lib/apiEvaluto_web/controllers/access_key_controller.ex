defmodule ApiEvalutoWeb.AccessKeyController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.AccessKey

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    access_keys = Accounts.list_access_keys()
    render(conn, "index.json", access_keys: access_keys)
  end

  def create(conn, %{"access_key" => access_key_params}) do
    with {:ok, %AccessKey{} = access_key} <- Accounts.create_access_key(access_key_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", access_key_path(conn, :show, access_key))
      |> render("show.json", access_key: access_key)
    end
  end

  def show(conn, %{"id" => id}) do
    access_key = Accounts.get_access_key!(id)
    render(conn, "show.json", access_key: access_key)
  end

  def update(conn, %{"id" => id, "access_key" => access_key_params}) do
    access_key = Accounts.get_access_key!(id)

    with {:ok, %AccessKey{} = access_key} <- Accounts.update_access_key(access_key, access_key_params) do
      render(conn, "show.json", access_key: access_key)
    end
  end

  def delete(conn, %{"id" => id}) do
    access_key = Accounts.get_access_key!(id)
    with {:ok, %AccessKey{}} <- Accounts.delete_access_key(access_key) do
      send_resp(conn, :no_content, "")
    end
  end
end
