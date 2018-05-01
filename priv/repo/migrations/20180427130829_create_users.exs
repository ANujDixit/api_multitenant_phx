defmodule ApiEvaluto.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :email_verified, :boolean, default: false, null: false
      add :active, :boolean,  default: false, null: true
      
      add :user_type_id, references(:user_types, on_delete: :nothing, type: :binary_id )
      add :tenant_id, references(:tenants, on_delete: :delete_all, type: :binary_id ), null: false

      timestamps()
    end

    create index(:users, [:tenant_id])
  end
end
