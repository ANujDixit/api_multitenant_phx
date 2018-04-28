defmodule ApiEvaluto.Accounts.Access.Registration do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo        
      alias ApiEvaluto.Accounts.Registration

      def register(attrs \\ %{}) do
        changeset = Registration.changeset(%Registration{}, attrs)  
        if changeset.valid? do
          case Repo.transaction(to_multi(attrs)) do
            {:ok, _} ->
              redirect conn, to: registration_path(conn, :new)
            {:error, _operation, repo_changeset, _changes} ->
              changeset = copy_errors(repo_changeset, changeset)
              %{:error, %{changeset | action: :insert}}
          end
        else
          %{:error, %{changeset | action: :insert}}
        end
      end

      defp to_multi(attrs) do
        Ecto.Multi.new()
          |> Ecto.Multi.insert(:tenant, tenant_changeset(attrs))
          |> Ecto.Multi.run(:group, fn changes -> Repo.insert group_changeset(changes) end)
          |> Ecto.Multi.run(:user,  fn changes -> Repo.insert user_changeset(attrs, changes) end)
          |> Ecto.Multi.run(:credential, fn changes -> Repo.insert credential_changeset(attrs, changes) end)
          |> Ecto.Multi.run(:membership, fn changes -> Repo.insert membership_changeset(changes) end)
      end

      defp tenant_changeset(%{"tenant_name" => tenant_name}) do
        Tenant.changeset(%Tenant{}, %{name: tenant_name} )
      end

      defp group_changeset(changes) do
        changes.tenant
        |> Ecto.build_assoc(:groups, with: &Group.registration_changeset/2)
      end
        
    end
  end
end