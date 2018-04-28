defmodule ApiEvaluto.Accounts.Access.Credential do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo
      alias ApiEvaluto.Accounts.Credential

      def list_credentials do
        Repo.all(Credential)
      end

      def get_credential!(id), do: Repo.get!(Credential, id)

      def create_credential(attrs \\ %{}) do
        %Credential{}
        |> Credential.changeset(attrs)
        |> Repo.insert()
      end

      def update_credential(%Credential{} = credential, attrs) do
        credential
        |> Credential.changeset(attrs)
        |> Repo.update()
      end

      def delete_credential(%Credential{} = credential) do
        Repo.delete(credential)
      end
        
    end
  end
end