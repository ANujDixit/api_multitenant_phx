defmodule ApiEvaluto.Accounts.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiEvaluto.Accounts.{Tenant, Group, User}
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "memberships" do
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id
    belongs_to :group, Group, foreign_key: :group_id, type: :binary_id
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id   

    timestamps()
  end

  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint(:user_id, name: :tenant_group_user)
  end
end
