defmodule ApiEvaluto.Authorization.AccessKey do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Authorization.Role

  schema "access_keys" do
    field :name, :string
    
    belongs_to :role, Role, foreign_key: :role_id, type: :binary_id
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id

    timestamps()
  end

  def changeset(access_key, attrs) do
    access_key
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
