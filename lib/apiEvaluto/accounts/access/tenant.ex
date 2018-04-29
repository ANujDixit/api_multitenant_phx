defmodule ApiEvaluto.Accounts.Access.Tenant do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo             
      alias ApiEvaluto.Accounts.Tenant

      def list_tenants do
        Repo.all(Tenant)
      end

      def get_tenant!(id), do: Repo.get!(Tenant, id)

      def get_tenant_by_code(code), do: Repo.get_by(Tenant, code: code)

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
              
    end
  end
end