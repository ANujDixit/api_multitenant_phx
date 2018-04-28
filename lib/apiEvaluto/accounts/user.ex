defmodule ApiEvaluto.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias ApiEvaluto.Accounts.Tenant
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
