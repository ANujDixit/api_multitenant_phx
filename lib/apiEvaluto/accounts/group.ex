defmodule ApiEvaluto.Accounts.Group do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias ApiEvaluto.Accounts.Tenant
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "groups" do
    field :active, :boolean, default: false
    field :name, :string
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end
 
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
