defmodule ApiEvaluto.Repo.Migrations.CreateTenants do
  use Ecto.Migration

  def change do
    create table(:tenants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :slug, :string
      add :code, :string
      add :verified, :boolean, default: false, null: false
      add :active, :boolean,  default: false, null: true

      timestamps()
    end

    create unique_index(:tenants, [:name])
    create unique_index(:tenants, [:slug])
    create unique_index(:tenants, [:code])
  end
end
