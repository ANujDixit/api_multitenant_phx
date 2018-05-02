defmodule ApiEvalutoWeb.AbilitiesControllerTest do
  use ApiEvalutoWeb.ConnCase

  alias ApiEvaluto.Authorization
  alias ApiEvaluto.Authorization.Abilities

  @create_attrs %{create: "some create", delete: "some delete", read: "some read", update: "some update"}
  @update_attrs %{create: "some updated create", delete: "some updated delete", read: "some updated read", update: "some updated update"}
  @invalid_attrs %{create: nil, delete: nil, read: nil, update: nil}

  def fixture(:abilities) do
    {:ok, abilities} = Authorization.create_abilities(@create_attrs)
    abilities
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all abilities", %{conn: conn} do
      conn = get conn, abilities_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create abilities" do
    test "renders abilities when data is valid", %{conn: conn} do
      conn = post conn, abilities_path(conn, :create), abilities: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, abilities_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "create" => "some create",
        "delete" => "some delete",
        "read" => "some read",
        "update" => "some update"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, abilities_path(conn, :create), abilities: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update abilities" do
    setup [:create_abilities]

    test "renders abilities when data is valid", %{conn: conn, abilities: %Abilities{id: id} = abilities} do
      conn = put conn, abilities_path(conn, :update, abilities), abilities: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, abilities_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "create" => "some updated create",
        "delete" => "some updated delete",
        "read" => "some updated read",
        "update" => "some updated update"}
    end

    test "renders errors when data is invalid", %{conn: conn, abilities: abilities} do
      conn = put conn, abilities_path(conn, :update, abilities), abilities: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete abilities" do
    setup [:create_abilities]

    test "deletes chosen abilities", %{conn: conn, abilities: abilities} do
      conn = delete conn, abilities_path(conn, :delete, abilities)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, abilities_path(conn, :show, abilities)
      end
    end
  end

  defp create_abilities(_) do
    abilities = fixture(:abilities)
    {:ok, abilities: abilities}
  end
end
