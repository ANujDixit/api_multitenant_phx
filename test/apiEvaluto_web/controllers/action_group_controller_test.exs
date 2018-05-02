defmodule ApiEvalutoWeb.ActionGroupControllerTest do
  use ApiEvalutoWeb.ConnCase

  alias ApiEvaluto.Authorization
  alias ApiEvaluto.Authorization.ActionGroup

  @create_attrs %{active: true, name: "some name"}
  @update_attrs %{active: false, name: "some updated name"}
  @invalid_attrs %{active: nil, name: nil}

  def fixture(:action_group) do
    {:ok, action_group} = Authorization.create_action_group(@create_attrs)
    action_group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all action_groups", %{conn: conn} do
      conn = get conn, action_group_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create action_group" do
    test "renders action_group when data is valid", %{conn: conn} do
      conn = post conn, action_group_path(conn, :create), action_group: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, action_group_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active" => true,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, action_group_path(conn, :create), action_group: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update action_group" do
    setup [:create_action_group]

    test "renders action_group when data is valid", %{conn: conn, action_group: %ActionGroup{id: id} = action_group} do
      conn = put conn, action_group_path(conn, :update, action_group), action_group: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, action_group_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active" => false,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, action_group: action_group} do
      conn = put conn, action_group_path(conn, :update, action_group), action_group: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete action_group" do
    setup [:create_action_group]

    test "deletes chosen action_group", %{conn: conn, action_group: action_group} do
      conn = delete conn, action_group_path(conn, :delete, action_group)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, action_group_path(conn, :show, action_group)
      end
    end
  end

  defp create_action_group(_) do
    action_group = fixture(:action_group)
    {:ok, action_group: action_group}
  end
end
