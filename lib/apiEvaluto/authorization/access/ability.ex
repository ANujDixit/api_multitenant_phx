defmodule ApiEvaluto.Authorization.Access.Ability do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo     
      
      alias ApiEvaluto.Authorization.Ability
 
      def list_abilities do
        Repo.all(Ability)
      end

      def get_ability!(id), do: Repo.get!(Ability, id)

      def create_ability(attrs \\ %{}) do
        %Ability{}
        |> Ability.changeset(attrs)
        |> Repo.insert()
      end

      def update_ability(%Ability{} = ability, attrs) do
        ability
        |> Ability.changeset(attrs)
        |> Repo.update()
      end

      def delete_ability(%Ability{} = ability) do
        Repo.delete(ability)
      end

    end
  end
end