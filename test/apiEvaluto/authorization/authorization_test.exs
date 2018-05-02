defmodule ApiEvaluto.AuthorizationTest do
  use ApiEvaluto.DataCase

  alias ApiEvaluto.Authorization

  describe "action_groups" do
    alias ApiEvaluto.Authorization.ActionGroup

    @valid_attrs %{active: true, name: "some name"}
    @update_attrs %{active: false, name: "some updated name"}
    @invalid_attrs %{active: nil, name: nil}

    def action_group_fixture(attrs \\ %{}) do
      {:ok, action_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorization.create_action_group()

      action_group
    end

    test "list_action_groups/0 returns all action_groups" do
      action_group = action_group_fixture()
      assert Authorization.list_action_groups() == [action_group]
    end

    test "get_action_group!/1 returns the action_group with given id" do
      action_group = action_group_fixture()
      assert Authorization.get_action_group!(action_group.id) == action_group
    end

    test "create_action_group/1 with valid data creates a action_group" do
      assert {:ok, %ActionGroup{} = action_group} = Authorization.create_action_group(@valid_attrs)
      assert action_group.active == true
      assert action_group.name == "some name"
    end

    test "create_action_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authorization.create_action_group(@invalid_attrs)
    end

    test "update_action_group/2 with valid data updates the action_group" do
      action_group = action_group_fixture()
      assert {:ok, action_group} = Authorization.update_action_group(action_group, @update_attrs)
      assert %ActionGroup{} = action_group
      assert action_group.active == false
      assert action_group.name == "some updated name"
    end

    test "update_action_group/2 with invalid data returns error changeset" do
      action_group = action_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Authorization.update_action_group(action_group, @invalid_attrs)
      assert action_group == Authorization.get_action_group!(action_group.id)
    end

    test "delete_action_group/1 deletes the action_group" do
      action_group = action_group_fixture()
      assert {:ok, %ActionGroup{}} = Authorization.delete_action_group(action_group)
      assert_raise Ecto.NoResultsError, fn -> Authorization.get_action_group!(action_group.id) end
    end

    test "change_action_group/1 returns a action_group changeset" do
      action_group = action_group_fixture()
      assert %Ecto.Changeset{} = Authorization.change_action_group(action_group)
    end
  end

  describe "actions" do
    alias ApiEvaluto.Authorization.Action

    @valid_attrs %{active: true, endpoint: "some endpoint", name: "some name", params: "some params"}
    @update_attrs %{active: false, endpoint: "some updated endpoint", name: "some updated name", params: "some updated params"}
    @invalid_attrs %{active: nil, endpoint: nil, name: nil, params: nil}

    def action_fixture(attrs \\ %{}) do
      {:ok, action} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorization.create_action()

      action
    end

    test "list_actions/0 returns all actions" do
      action = action_fixture()
      assert Authorization.list_actions() == [action]
    end

    test "get_action!/1 returns the action with given id" do
      action = action_fixture()
      assert Authorization.get_action!(action.id) == action
    end

    test "create_action/1 with valid data creates a action" do
      assert {:ok, %Action{} = action} = Authorization.create_action(@valid_attrs)
      assert action.active == true
      assert action.endpoint == "some endpoint"
      assert action.name == "some name"
      assert action.params == "some params"
    end

    test "create_action/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authorization.create_action(@invalid_attrs)
    end

    test "update_action/2 with valid data updates the action" do
      action = action_fixture()
      assert {:ok, action} = Authorization.update_action(action, @update_attrs)
      assert %Action{} = action
      assert action.active == false
      assert action.endpoint == "some updated endpoint"
      assert action.name == "some updated name"
      assert action.params == "some updated params"
    end

    test "update_action/2 with invalid data returns error changeset" do
      action = action_fixture()
      assert {:error, %Ecto.Changeset{}} = Authorization.update_action(action, @invalid_attrs)
      assert action == Authorization.get_action!(action.id)
    end

    test "delete_action/1 deletes the action" do
      action = action_fixture()
      assert {:ok, %Action{}} = Authorization.delete_action(action)
      assert_raise Ecto.NoResultsError, fn -> Authorization.get_action!(action.id) end
    end

    test "change_action/1 returns a action changeset" do
      action = action_fixture()
      assert %Ecto.Changeset{} = Authorization.change_action(action)
    end
  end

  describe "abilities" do
    alias ApiEvaluto.Authorization.Abilities

    @valid_attrs %{create: "some create", delete: "some delete", read: "some read", update: "some update"}
    @update_attrs %{create: "some updated create", delete: "some updated delete", read: "some updated read", update: "some updated update"}
    @invalid_attrs %{create: nil, delete: nil, read: nil, update: nil}

    def abilities_fixture(attrs \\ %{}) do
      {:ok, abilities} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorization.create_abilities()

      abilities
    end

    test "list_abilities/0 returns all abilities" do
      abilities = abilities_fixture()
      assert Authorization.list_abilities() == [abilities]
    end

    test "get_abilities!/1 returns the abilities with given id" do
      abilities = abilities_fixture()
      assert Authorization.get_abilities!(abilities.id) == abilities
    end

    test "create_abilities/1 with valid data creates a abilities" do
      assert {:ok, %Abilities{} = abilities} = Authorization.create_abilities(@valid_attrs)
      assert abilities.create == "some create"
      assert abilities.delete == "some delete"
      assert abilities.read == "some read"
      assert abilities.update == "some update"
    end

    test "create_abilities/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authorization.create_abilities(@invalid_attrs)
    end

    test "update_abilities/2 with valid data updates the abilities" do
      abilities = abilities_fixture()
      assert {:ok, abilities} = Authorization.update_abilities(abilities, @update_attrs)
      assert %Abilities{} = abilities
      assert abilities.create == "some updated create"
      assert abilities.delete == "some updated delete"
      assert abilities.read == "some updated read"
      assert abilities.update == "some updated update"
    end

    test "update_abilities/2 with invalid data returns error changeset" do
      abilities = abilities_fixture()
      assert {:error, %Ecto.Changeset{}} = Authorization.update_abilities(abilities, @invalid_attrs)
      assert abilities == Authorization.get_abilities!(abilities.id)
    end

    test "delete_abilities/1 deletes the abilities" do
      abilities = abilities_fixture()
      assert {:ok, %Abilities{}} = Authorization.delete_abilities(abilities)
      assert_raise Ecto.NoResultsError, fn -> Authorization.get_abilities!(abilities.id) end
    end

    test "change_abilities/1 returns a abilities changeset" do
      abilities = abilities_fixture()
      assert %Ecto.Changeset{} = Authorization.change_abilities(abilities)
    end
  end
end
