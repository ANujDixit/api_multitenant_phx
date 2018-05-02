defmodule ApiEvaluto.Repo.Migrations.CreateActionGroups do
  use Ecto.Migration

  def change do
    create table(:action_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :active, :boolean, default: false, null: false   

      timestamps()
    end
  
  end
end
