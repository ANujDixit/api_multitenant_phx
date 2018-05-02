defmodule ApiEvaluto.Authorization.Access.AccessKey do
    defmacro __using__(_) do
      quote do
        import Ecto.Query, warn: false
        alias ApiEvaluto.Repo             
        alias ApiEvaluto.Authorization.AccessKey
       
        def list_access_keys(tenant) do         
            AccessKey
            |> where([ak], ak.tenant_id == ^tenant.id)
            |> order_by(desc: :updated_at)
            |> Repo.all()
        end
    
        def get_access_key!(tenant, id) do
            AccessKey
            |> where([ak], ak.tenant_id == ^tenant.id)
            |> Repo.get!(id)          
        end    
 
        def create_access_key(tenant, attrs \\ %{}) do            
            Ecto.build_assoc(tenant, :access_keys)
            |> AccessKey.changeset(attrs)
            |> Repo.insert()
        end

        def update_access_key(%AccessKey{} = access_key, attrs) do
            access_key
            |> AccessKey.changeset(attrs)
            |> Repo.update()
        end

        def delete_access_key(%AccessKey{} = access_key) do
            Repo.delete(access_key)
        end        
          
      end
    end
end