defmodule ApiEvaluto.Authorization.Ability do
  use ApiEvaluto.Schema 

  alias ApiEvaluto.Authorization.Action

  schema "ability" do
    field :create, :string
    field :delete, :string
    field :read, :string
    field :update, :string
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id
    belongs_to :action, Action, foreign_key: :action_id, type: :binary_id   

    timestamps()
  end

  def changeset(ability, attrs) do
    ability
    |> cast(attrs, [:create, :read, :update, :delete])
    |> validate_required([:create, :read, :update, :delete])
  end
end
