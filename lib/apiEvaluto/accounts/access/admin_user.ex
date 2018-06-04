defmodule ApiEvaluto.Accounts.Access.AdminUser do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo
      alias ApiEvaluto.Accounts.AdminUser

      def list_admin_users do
        Repo.all(AdminUser)
      end

      def get_admin_user!(id), do: Repo.get!(AdminUser, id)

      def get_admin_user_by_email(email) do
        AdminUser
        |> Repo.get_by(email: email)
        |> case do
          nil -> {:error, :admin_user_not_found}
          admin_user -> admin_user
        end
      end

      def create_admin_user(attrs \\ %{}) do
        %AdminUser{}
        |> AdminUser.changeset(attrs)
        |> Repo.insert()
      end

      def update_credential(%AdminUser{} = admin_user, attrs) do
        AdminUser
        |> AdminUser.changeset(attrs)
        |> Repo.update()
      end

      def delete_admin_user(%AdminUser{} = admin_user) do
        Repo.delete(admin_user)
      end
        
    end
  end
end