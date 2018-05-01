defmodule ApiEvaluto.Accounts.Access.Tenant do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo             
      alias ApiEvaluto.Accounts.{Tenant, User}

      def list_tenants do
        Repo.all(Tenant)
      end

      def get_tenant!(id), do: Repo.get!(Tenant, id)

      def get_tenant_by_code(code), do: Repo.get_by(Tenant, code: code)

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