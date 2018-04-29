defmodule ApiEvaluto.Accounts.Group do
  use ApiEvaluto.Schema    
  alias ApiEvaluto.Accounts.Membership

  schema "groups" do
    field :active, :boolean, default: false
    field :name, :string
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    has_many :memberships, Membership
    has_many :users, through: [:memberships, :user]

    timestamps()
  end
 
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
    |> unique_constraint(:name, name: :tenant_name)
  end

end
