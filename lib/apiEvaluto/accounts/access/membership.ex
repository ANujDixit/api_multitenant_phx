defmodule ApiEvaluto.Accounts.Access.Membership do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo          
      alias ApiEvaluto.Accounts.Membership

      def list_memberships do
        Repo.all(Membership)
      end

      def get_membership!(id), do: Repo.get!(Membership, id)
    
      def create_membership(attrs \\ %{}) do
        %Membership{}
        |> Membership.changeset(attrs)
        |> Repo.insert()
      end

      def update_membership(%Membership{} = membership, attrs) do
        membership
        |> Membership.changeset(attrs)
        |> Repo.update()
      end

      def delete_membership(%Membership{} = membership) do
        Repo.delete(membership)
      end
        
    end
  end
end