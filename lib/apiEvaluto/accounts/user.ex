defmodule ApiEvaluto.Accounts.User do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Accounts.UserType
  
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    
    belongs_to :user_type, UserType, foreign_key: :user_type_id, type: :binary_id
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
