defmodule ApiEvaluto.Authorization.Access.Role do
    defmacro __using__(_) do
      quote do
        import Ecto.Query, warn: false
        alias ApiEvaluto.Repo     
        alias ApiEvaluto.Authorization.Role
 
        def list_roles(tenant) do
            Role
            |> where([ut], ut.tenant_id == ^tenant.id)
            |> order_by(desc: :updated_at)
            |> Repo.all()           
        end

        def get_role!(tenant, id) do          
            Role
            |> where([ut], ut.tenant_id == ^tenant.id)
            |> Repo.get!(id)
        end    

        def create_role(tenant, attrs \\ %{}) do
            Ecto.build_assoc(tenant, :roles)
            |> Role.changeset(attrs)
            |> Repo.insert()
        end
    
        def update_role(%Role{} = role, attrs) do
            role
            |> Role.changeset(attrs)
            |> Repo.update()           
        end

        def delete_role(%Role{} = role) do
            Repo.delete(role)
        end         
                
      end
    end
end