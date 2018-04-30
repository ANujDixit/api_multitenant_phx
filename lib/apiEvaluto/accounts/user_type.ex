defmodule ApiEvaluto.Accounts.UserType do
  use ApiEvaluto.Schema     
  alias ApiEvaluto.Accounts.User

  schema "user_types" do    
    field :name, :string   
    field :security_level, :integer 
    
    has_many :users, User
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end

  def changeset(user_type, attrs) do
    user_type
    |> cast(attrs, [:name, :security_level])
    |> validate_required([:name, :security_level])
    |> unique_constraint(:name)
  end
end
