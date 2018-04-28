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
    Ecto.build_assoc(tenant, :users, attrs)
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

  def get_group!(id), do: Repo.get!(Group, id)
 
  def create_group(attrs \\ %{}) do
    %Group{}
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

end
