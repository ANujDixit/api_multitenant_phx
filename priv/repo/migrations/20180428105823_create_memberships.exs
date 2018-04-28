defmodule ApiEvaluto.Repo.Migrations.CreateMemberships do
  use Ecto.Migration

  def change do
    create table(:memberships, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id), null: false
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false
      add :group_id, references(:groups, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:memberships, [:tenant_id])
    create index(:memberships, [:user_id])
    create index(:memberships, [:group_id])

    create unique_index(:memberships, [:tenant_id, :group_id, :user_id], name: :tenant_group_user)
  end
end
