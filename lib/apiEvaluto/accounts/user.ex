defmodule ApiEvaluto.Accounts.User do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Authorization.{Role, Credential}
  
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email_verified, :boolean
    field :active, :boolean

    has_many :credentials, Credential

    belongs_to :role, Role, foreign_key: :role_id, type: :binary_id
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email_verified, :active])
    |> validate_required([:first_name, :last_name])
  end
end
