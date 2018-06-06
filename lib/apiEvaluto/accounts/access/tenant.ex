defmodule ApiEvaluto.Accounts.Access.Tenant do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo             
      alias ApiEvaluto.Accounts.{Tenant, User, Credential}

      def list_tenants do
        Repo.all(Tenant)
      end

      def list_tenants_with_owner_details do
        query = from(t in Tenant, 
                join: u in assoc(t, :users), 
                join: cr in assoc(u, :credentials),     
                select: %{id: t.id, name: t.name, code: t.code, active: t.active, created_date: t.inserted_at,
                          owner_name: fragment("concat(?, ' ', ?)", u.first_name, u.last_name), 
                          email: cr.email},          
                order_by: [asc: [t.inserted_at, u.inserted_at]],
                limit: 1)

        Repo.all(query)     
      end    

      def get_tenant!(id), do: Repo.get!(Tenant, id)
      
      def get_tenants_by_name(name) do
        from(t in Tenant, where: t.name == ^name)
        |> Repo.all()
      end 
      
      def get_tenants_by_code(code) do
        from(t in Tenant, where: t.code == ^code)
        |> Repo.all()
      end 

      def get_tenant_by_code(code) do
        Tenant
        |> Repo.get_by(code: code)
        |> case do
          nil -> {:error, :tenant_not_found}
          tenant -> tenant
        end
      end 

      def get_tenant_by_slug(slug), do: Repo.get_by(Tenant, slug: slug)     
      
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
      
      def verify_tenant(%Tenant{} = tenant, %User{} = user) do
          Ecto.Multi.new()
          |> Ecto.Multi.update(:tenant, Tenant.changeset(tenant, %{verified: true}))
          |> Ecto.Multi.update(:user, User.changeset(user, %{email_verified: true}))
          |> Repo.transaction()
          |>  case do
                {:ok, %{tenant: tenant, user: user}} -> {:ok, tenant}
                {:error, op, res, others} -> {:error, op}
              end
      end
      
    end 
  end
end