defmodule ApiEvaluto.Repo.Migrations.CreateAccessKeys do
  use Ecto.Migration

  def change do
    create table(:access_keys, primary_key: false) do
      add :id, :binary_id, primary_key: true 
      add :name, :string
      add :user_type_id, references(:user_types, on_delete: :delete_all, type: :binary_id)
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:access_keys, [:user_type_id])
    create index(:access_keys, [:tenant_id])
  end
end
