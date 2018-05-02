defmodule ApiEvaluto.Repo.Migrations.CreateAbilities do
  use Ecto.Migration

  def change do
    create table(:abilities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :create, :integer
      add :read, :integer
      add :update, :integer
      add :delete, :integer
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id ), null: false
      add :action_id, references(:actions, on_delete: :delete_all, type: :binary_id ), null: false

      timestamps()
    end

    create index(:abilities, [:tenant_id])
    create index(:abilities, [:action_id])
  end
end
