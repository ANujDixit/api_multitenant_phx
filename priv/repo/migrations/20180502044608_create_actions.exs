defmodule ApiEvaluto.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :endpoint, :string
      add :params, :string
      add :active, :boolean, default: false, null: false   
      add :action_group_id, references(:action_groups, on_delete: :delete_all, type: :binary_id ), null: false

      timestamps()
    end

    create index(:actions, [:action_group_id])
  end
end
