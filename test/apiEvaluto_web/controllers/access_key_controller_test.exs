defmodule ApiEvalutoWeb.AccessKeyControllerTest do
  use ApiEvalutoWeb.ConnCase

  alias ApiEvaluto.Accounts
  alias ApiEvaluto.Accounts.AccessKey

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:access_key) do
    {:ok, access_key} = Accounts.create_access_key(@create_attrs)
    access_key
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all access_keys", %{conn: conn} do
      conn = get conn, access_key_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create access_key" do
    test "renders access_key when data is valid", %{conn: conn} do
      conn = post conn, access_key_path(conn, :create), access_key: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, access_key_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, access_key_path(conn, :create), access_key: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update access_key" do
    setup [:create_access_key]

    test "renders access_key when data is valid", %{conn: conn, access_key: %AccessKey{id: id} = access_key} do
      conn = put conn, access_key_path(conn, :update, access_key), access_key: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, access_key_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, access_key: access_key} do
      conn = put conn, access_key_path(conn, :update, access_key), access_key: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete access_key" do
    setup [:create_access_key]

    test "deletes chosen access_key", %{conn: conn, access_key: access_key} do
      conn = delete conn, access_key_path(conn, :delete, access_key)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, access_key_path(conn, :show, access_key)
      end
    end
  end

  defp create_access_key(_) do
    access_key = fixture(:access_key)
    {:ok, access_key: access_key}
  end
end
