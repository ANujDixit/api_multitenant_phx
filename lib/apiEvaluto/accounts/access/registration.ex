defmodule ApiEvaluto.Accounts.Access.Registration do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo        
      alias ApiEvaluto.Accounts.{Registration, Tenant, Group, User, Credential, Membership}

      def register(attrs \\ %{}) do
        changeset = Registration.changeset(%Registration{}, attrs)  
        if changeset.valid? do
          case Repo.transaction(to_multi(attrs)) do
            {:ok, %{tenant: tenant}} ->
              {:ok, tenant}
            {:error, _operation, repo_changeset, _changes} ->
              changeset = %{copy_errors(repo_changeset, changeset) | action: :insert}
              {:error, changeset}
          end
        else
          changeset = %{changeset | action: :insert}
          {:error, changeset}
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
        |> Ecto.build_assoc(:groups)
        |> Group.registration_changeset(%{name: "Owner", active: 1})
      end

      defp user_changeset(%{"first_name" => first_name, "last_name" => last_name}, changes) do
        changes.tenant
        |> Ecto.build_assoc(:users) 
        |> User.changeset(%{first_name: first_name, last_name: last_name})
      end

      defp credential_changeset(attrs, changes) do       
        changes.tenant
        |> Ecto.build_assoc(:credentials)        
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.put_assoc(:user, changes.user)
        |> Credential.changeset(Map.put(attrs, "auth_type", 1))  
      end
      
      defp membership_changeset(changes) do
        changes.tenant
        |> Ecto.build_assoc(:memberships)
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.put_assoc(:group, changes.group)
        |> Ecto.Changeset.put_assoc(:user, changes.user)
        |> Membership.changeset(%{})  
      end

      defp copy_errors(from, to) do
        Enum.reduce from.errors, to, fn {field, {msg, additional}}, acc ->
          Ecto.Changeset.add_error(acc, field, msg, additional: additional)
        end
      end
        
    end
  end
end