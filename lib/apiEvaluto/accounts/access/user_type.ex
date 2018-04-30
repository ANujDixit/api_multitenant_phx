defmodule ApiEvaluto.Accounts.Access.UserType do
    defmacro __using__(_) do
      quote do
        import Ecto.Query, warn: false
        alias ApiEvaluto.Repo     
        alias ApiEvaluto.Accounts.UserType
 
        def list_user_types(tenant) do
            UserType
            |> where([ut], ut.tenant_id == ^tenant.id)
            |> order_by(desc: :updated_at)
            |> Repo.all()           
        end

        def get_user_type!(tenant, id) do          
            UserType
            |> where([ut], ut.tenant_id == ^tenant.id)
            |> Repo.get!(id)
        end    

        def create_user_type(tenant, attrs \\ %{}) do
            Ecto.build_assoc(tenant, :user_types)
            |> UserType.changeset(attrs)
            |> Repo.insert()
        end
    
        def update_user_type(%UserType{} = user_type, attrs) do
            user_type
            |> UserType.changeset(attrs)
            |> Repo.update()           
        end

        def delete_user_type(%UserType{} = user_type) do
            Repo.delete(user_type)
        end         
                
      end
    end
end