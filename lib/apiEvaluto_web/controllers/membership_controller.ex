defmodule ApiEvalutoWeb.MembershipController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.Membership

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    memberships = Accounts.list_memberships()
    render(conn, "index.json", memberships: memberships)
  end

  def create(conn, %{"membership" => membership_params}) do
    with {:ok, %Membership{} = membership} <- Accounts.create_membership(membership_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", membership_path(conn, :show, membership))
      |> render("show.json", membership: membership)
    end
  end

  def show(conn, %{"id" => id}) do
    membership = Accounts.get_membership!(id)
    render(conn, "show.json", membership: membership)
  end

  def update(conn, %{"id" => id, "membership" => membership_params}) do
    membership = Accounts.get_membership!(id)

    with {:ok, %Membership{} = membership} <- Accounts.update_membership(membership, membership_params) do
      render(conn, "show.json", membership: membership)
    end
  end

  def delete(conn, %{"id" => id}) do
    membership = Accounts.get_membership!(id)
    with {:ok, %Membership{}} <- Accounts.delete_membership(membership) do
      send_resp(conn, :no_content, "")
    end
  end
end
