defmodule ApiEvaluto.Repo.Migrations.CreateAdminUsers do
  use Ecto.Migration

  def change do
    create table(:admin_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:admin_users, [:email])
  
  end
end
