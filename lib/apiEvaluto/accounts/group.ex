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
  end

  def registration_changeset(group, attrs) do
    group
    |> cast(attrs, [:tenant_id])
    |> validate_required([:tenant_id])
    |> make_first_user_as_owner()
    |> unique_constraint(:name, name: :groups_name_company_id_index)
  end

end
