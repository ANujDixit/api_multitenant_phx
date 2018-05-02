defmodule ApiEvaluto.Authorization.ActionGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "action_groups" do
    field :active, :boolean, default: false
    field :name, :string   

    timestamps()
  end

  def changeset(action_group, attrs) do
    action_group
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
