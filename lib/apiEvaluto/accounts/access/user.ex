defmodule ApiEvaluto.Accounts.Access.Group do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo            
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
        
    end
  end
end