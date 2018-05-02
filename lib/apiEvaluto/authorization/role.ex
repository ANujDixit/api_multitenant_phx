defmodule ApiEvaluto.Authorization.Role do
  use ApiEvaluto.Schema     
  alias ApiEvaluto.Accounts.User

  schema "roles" do    
    field :name, :string   
    field :security_level, :integer 
    
    has_many :users, User
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :security_level])
    |> validate_required([:name, :security_level])
    |> unique_constraint(:name)
  end
end
