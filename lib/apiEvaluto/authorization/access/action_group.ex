defmodule ApiEvaluto.Authorization.Access.ActionGroup do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo    
      
      alias ApiEvaluto.Authorization.ActionGroup

      def list_action_groups do
        Repo.all(ActionGroup)
      end
 
      def get_action_group!(id), do: Repo.get!(ActionGroup, id)

      def create_action_group(attrs \\ %{}) do
        %ActionGroup{}
        |> ActionGroup.changeset(attrs)
        |> Repo.insert()
      end

      def update_action_group(%ActionGroup{} = action_group, attrs) do
        action_group
        |> ActionGroup.changeset(attrs)
        |> Repo.update()
      end

      def delete_action_group(%ActionGroup{} = action_group) do
        Repo.delete(action_group)
      end
      
    end
  end
end