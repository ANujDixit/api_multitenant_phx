defmodule ApiEvaluto.AccountsTest do
  use ApiEvaluto.DataCase

  alias ApiEvaluto.Accounts

  describe "tenants" do
    alias ApiEvaluto.Accounts.Tenant

    @valid_attrs %{code: "some code", name: "some name", slug: "some slug"}
    @update_attrs %{code: "some updated code", name: "some updated name", slug: "some updated slug"}
    @invalid_attrs %{code: nil, name: nil, slug: nil}

    def tenant_fixture(attrs \\ %{}) do
      {:ok, tenant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_tenant()

      tenant
    end

    test "list_tenants/0 returns all tenants" do
      tenant = tenant_fixture()
      assert Accounts.list_tenants() == [tenant]
    end

    test "get_tenant!/1 returns the tenant with given id" do
      tenant = tenant_fixture()
      assert Accounts.get_tenant!(tenant.id) == tenant
    end

    test "create_tenant/1 with valid data creates a tenant" do
      assert {:ok, %Tenant{} = tenant} = Accounts.create_tenant(@valid_attrs)
      assert tenant.code == "some code"
      assert tenant.name == "some name"
      assert tenant.slug == "some slug"
    end

    test "create_tenant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_tenant(@invalid_attrs)
    end

    test "update_tenant/2 with valid data updates the tenant" do
      tenant = tenant_fixture()
      assert {:ok, tenant} = Accounts.update_tenant(tenant, @update_attrs)
      assert %Tenant{} = tenant
      assert tenant.code == "some updated code"
      assert tenant.name == "some updated name"
      assert tenant.slug == "some updated slug"
    end

    test "update_tenant/2 with invalid data returns error changeset" do
      tenant = tenant_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_tenant(tenant, @invalid_attrs)
      assert tenant == Accounts.get_tenant!(tenant.id)
    end

    test "delete_tenant/1 deletes the tenant" do
      tenant = tenant_fixture()
      assert {:ok, %Tenant{}} = Accounts.delete_tenant(tenant)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_tenant!(tenant.id) end
    end

    test "change_tenant/1 returns a tenant changeset" do
      tenant = tenant_fixture()
      assert %Ecto.Changeset{} = Accounts.change_tenant(tenant)
    end
  end

  describe "users" do
    alias ApiEvaluto.Accounts.User

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "groups" do
    alias ApiEvaluto.Accounts.Group

    @valid_attrs %{active: true, name: "some name"}
    @update_attrs %{active: false, name: "some updated name"}
    @invalid_attrs %{active: nil, name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Accounts.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Accounts.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Accounts.create_group(@valid_attrs)
      assert group.active == true
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, group} = Accounts.update_group(group, @update_attrs)
      assert %Group{} = group
      assert group.active == false
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_group(group, @invalid_attrs)
      assert group == Accounts.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Accounts.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Accounts.change_group(group)
    end
  end

  describe "credentials" do
    alias ApiEvaluto.Accounts.Credential

    @valid_attrs %{email: "some email", password_hash: "some password_hash"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash"}
    @invalid_attrs %{email: nil, password_hash: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Accounts.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Accounts.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      assert credential.email == "some email"
      assert credential.password_hash == "some password_hash"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Accounts.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
      assert credential.password_hash == "some updated password_hash"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      assert credential == Accounts.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end

  describe "memberships" do
    alias ApiEvaluto.Accounts.Membership

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def membership_fixture(attrs \\ %{}) do
      {:ok, membership} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_membership()

      membership
    end

    test "list_memberships/0 returns all memberships" do
      membership = membership_fixture()
      assert Accounts.list_memberships() == [membership]
    end

    test "get_membership!/1 returns the membership with given id" do
      membership = membership_fixture()
      assert Accounts.get_membership!(membership.id) == membership
    end

    test "create_membership/1 with valid data creates a membership" do
      assert {:ok, %Membership{} = membership} = Accounts.create_membership(@valid_attrs)
    end

    test "create_membership/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_membership(@invalid_attrs)
    end

    test "update_membership/2 with valid data updates the membership" do
      membership = membership_fixture()
      assert {:ok, membership} = Accounts.update_membership(membership, @update_attrs)
      assert %Membership{} = membership
    end

    test "update_membership/2 with invalid data returns error changeset" do
      membership = membership_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_membership(membership, @invalid_attrs)
      assert membership == Accounts.get_membership!(membership.id)
    end

    test "delete_membership/1 deletes the membership" do
      membership = membership_fixture()
      assert {:ok, %Membership{}} = Accounts.delete_membership(membership)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_membership!(membership.id) end
    end

    test "change_membership/1 returns a membership changeset" do
      membership = membership_fixture()
      assert %Ecto.Changeset{} = Accounts.change_membership(membership)
    end
  end

  describe "user_types" do
    alias ApiEvaluto.Accounts.UserType

    @valid_attrs %{actions: [], name: "some name"}
    @update_attrs %{actions: [], name: "some updated name"}
    @invalid_attrs %{actions: nil, name: nil}

    def user_type_fixture(attrs \\ %{}) do
      {:ok, user_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_type()

      user_type
    end

    test "list_user_types/0 returns all user_types" do
      user_type = user_type_fixture()
      assert Accounts.list_user_types() == [user_type]
    end

    test "get_user_type!/1 returns the user_type with given id" do
      user_type = user_type_fixture()
      assert Accounts.get_user_type!(user_type.id) == user_type
    end

    test "create_user_type/1 with valid data creates a user_type" do
      assert {:ok, %UserType{} = user_type} = Accounts.create_user_type(@valid_attrs)
      assert user_type.actions == []
      assert user_type.name == "some name"
    end

    test "create_user_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_type(@invalid_attrs)
    end

    test "update_user_type/2 with valid data updates the user_type" do
      user_type = user_type_fixture()
      assert {:ok, user_type} = Accounts.update_user_type(user_type, @update_attrs)
      assert %UserType{} = user_type
      assert user_type.actions == []
      assert user_type.name == "some updated name"
    end

    test "update_user_type/2 with invalid data returns error changeset" do
      user_type = user_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_type(user_type, @invalid_attrs)
      assert user_type == Accounts.get_user_type!(user_type.id)
    end

    test "delete_user_type/1 deletes the user_type" do
      user_type = user_type_fixture()
      assert {:ok, %UserType{}} = Accounts.delete_user_type(user_type)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_type!(user_type.id) end
    end

    test "change_user_type/1 returns a user_type changeset" do
      user_type = user_type_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_type(user_type)
    end
  end

  describe "access_keys" do
    alias ApiEvaluto.Accounts.AccessKey

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def access_key_fixture(attrs \\ %{}) do
      {:ok, access_key} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_access_key()

      access_key
    end

    test "list_access_keys/0 returns all access_keys" do
      access_key = access_key_fixture()
      assert Accounts.list_access_keys() == [access_key]
    end

    test "get_access_key!/1 returns the access_key with given id" do
      access_key = access_key_fixture()
      assert Accounts.get_access_key!(access_key.id) == access_key
    end

    test "create_access_key/1 with valid data creates a access_key" do
      assert {:ok, %AccessKey{} = access_key} = Accounts.create_access_key(@valid_attrs)
      assert access_key.name == "some name"
    end

    test "create_access_key/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_access_key(@invalid_attrs)
    end

    test "update_access_key/2 with valid data updates the access_key" do
      access_key = access_key_fixture()
      assert {:ok, access_key} = Accounts.update_access_key(access_key, @update_attrs)
      assert %AccessKey{} = access_key
      assert access_key.name == "some updated name"
    end

    test "update_access_key/2 with invalid data returns error changeset" do
      access_key = access_key_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_access_key(access_key, @invalid_attrs)
      assert access_key == Accounts.get_access_key!(access_key.id)
    end

    test "delete_access_key/1 deletes the access_key" do
      access_key = access_key_fixture()
      assert {:ok, %AccessKey{}} = Accounts.delete_access_key(access_key)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_access_key!(access_key.id) end
    end

    test "change_access_key/1 returns a access_key changeset" do
      access_key = access_key_fixture()
      assert %Ecto.Changeset{} = Accounts.change_access_key(access_key)
    end
  end
end
