defmodule ApiEvaluto.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id ), null: false

      timestamps()
    end

    create index(:users, [:tenant_id])
  end
end
