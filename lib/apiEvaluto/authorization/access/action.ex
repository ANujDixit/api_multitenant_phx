defmodule ApiEvaluto.Authorization.Access.Action do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo     
      
      alias ApiEvaluto.Authorization.Action

      def list_actions do
        Repo.all(Action)
      end

      def get_action!(id), do: Repo.get!(Action, id)

      def create_action(attrs \\ %{}) do
        %Action{}
        |> Action.changeset(attrs)
        |> Repo.insert()
      end

      def update_action(%Action{} = action, attrs) do
        action
        |> Action.changeset(attrs)
        |> Repo.update()
      end

      def delete_action(%Action{} = action) do
        Repo.delete(action)
      end
 
    end
  end
end