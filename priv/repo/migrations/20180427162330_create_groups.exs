defmodule ApiEvaluto.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:groups, [:tenant_id])
    create unique_index(:groups, [:name ,:tenant_id])
  end
end
