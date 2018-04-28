defmodule ApiEvaluto.Accounts do
  import Ecto.Query, warn: false
  alias ApiEvaluto.Repo

  alias ApiEvaluto.Accounts.Tenant
 
  def list_tenants do
    Repo.all(Tenant)
  end

  def get_tenant!(id), do: Repo.get!(Tenant, id)

  def create_tenant(attrs \\ %{}) do
    %Tenant{}
    |> Tenant.changeset(attrs)
    |> Repo.insert()
  end

  def update_tenant(%Tenant{} = tenant, attrs) do
    tenant
    |> Tenant.changeset(attrs)
    |> Repo.update()
  end

  def delete_tenant(%Tenant{} = tenant) do
    Repo.delete(tenant)
  end

  alias ApiEvaluto.Accounts.User

  def list_users(tenant) do
    User
    |> where([u], u.tenant_id == ^tenant.id)
    |> order_by(desc: :updated_at)
    |> Repo.all()
  end

  def get_user!(tenant, id) do
    User
    |> where([u], u.tenant_id == ^tenant.id)
    |> Repo.get!(id)
  end  

  def create_user(tenant, attrs \\ %{}) do
    Ecto.build_assoc(tenant, :users)
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  alias ApiEvaluto.Accounts.Group

  def list_groups(tenant) do
    Group
    |> where([g], g.tenant_id == ^tenant.id)
    |> order_by(desc: :updated_at)
    |> Repo.all()
  end

  def get_group!(tenant, id) do 
    Group
    |> where([g], g.tenant_id == ^tenant.id)
    |> Repo.get!(id)
  end  
 
  def create_group(tenant, attrs \\ %{}) do
    Ecto.build_assoc(tenant, :groups)
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end


  alias ApiEvaluto.Accounts.Credential
 
  def list_credentials do
    Repo.all(Credential)
  end

  def get_credential!(id), do: Repo.get!(Credential, id)

  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  alias ApiEvaluto.Accounts.Membership

  def list_memberships do
    Repo.all(Membership)
  end

  def get_membership!(id), do: Repo.get!(Membership, id)
 
  def create_membership(attrs \\ %{}) do
    %Membership{}
    |> Membership.changeset(attrs)
    |> Repo.insert()
  end

  def update_membership(%Membership{} = membership, attrs) do
    membership
    |> Membership.changeset(attrs)
    |> Repo.update()
  end

  def delete_membership(%Membership{} = membership) do
    Repo.delete(membership)
  end

end
