defmodule ApiEvaluto.Authorization.Action do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias ApiEvaluto.Authorization.ActionGroup

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "actions" do
    field :active, :boolean, default: false
    field :endpoint, :string
    field :name, :string
    field :params, :string
    belongs_to :action_group, ActionGroup, foreign_key: :action_group_id, type: :binary_id    

    timestamps()
  end

  def changeset(action, attrs) do
    action
    |> cast(attrs, [:name, :endpoint, :params, :active])
    |> validate_required([:name, :endpoint, :params, :active])
  end
end
