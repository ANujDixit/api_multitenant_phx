defmodule ApiEvaluto.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :binary_id, primary_key: true       
      add :name, :string     
      add :security_level, :integer, default: 0
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:roles, [:tenant_id])
    create unique_index(:roles, [:tenant_id, :name], name: :tenant_role)
  end
end
