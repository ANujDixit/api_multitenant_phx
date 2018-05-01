defmodule ApiEvaluto.Accounts.Access.User do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo            
      alias ApiEvaluto.Accounts.{Tenant, User, UserType, Credential}

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
      
      def load_user_tenant_user_type(user_id) do   
        user_query = 
          from u in User, where: u.id == ^user_id, 
          join: t in Tenant, on: u.tenant_id == t.id,
          join: ut in UserType, on: u.user_type_id == ut.id,
          select: %{user: u, tenant: t, user_type: ut.name}
        Repo.one(user_query)  
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

      def is_admin(tenant, user) do   
        user = 
          User                                   
          |> where([u], u.tenant_id == ^tenant.id and u.id == ^user.id) 
          |> preload(:user_type)
          |> Repo.one() 

        user.user_type.name == "Admin"             
      end        
    end
  end
end