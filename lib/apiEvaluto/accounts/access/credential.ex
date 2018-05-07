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

      def get_credential_by_email(tenant, email) do
        Credential
        |> where([cr], cr.tenant_id == ^tenant.id)
        |> preload([user: :role])
        |> Repo.get_by(email: email)
      end

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