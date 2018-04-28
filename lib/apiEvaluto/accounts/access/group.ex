defmodule ApiEvaluto.Accounts.Access.Group do
  defmacro __using__(_) do
    quote do
        import Ecto.Query, warn: false
        alias ApiEvaluto.Repo            
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
        
    end
  end
end