defmodule ApiEvaluto.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :text
      add :instructions, :text
      add :negative_marking, :boolean, default: false, null: false
      add :total_marks, :decimal, default: 0.00
      
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id ), null: false
      add :created_by_id, references(:users, on_delete: :nothing, type: :binary_id ), null: false
      add :updated_by_id, references(:users, on_delete: :nothing, type: :binary_id ), null: false

      timestamps()
    end

    create index(:tests, [:tenant_id])
    create index(:tests, [:created_by_id])
    create index(:tests, [:updated_by_id])
  end
end
