defmodule ApiEvaluto.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias ApiEvaluto.Accounts.{Tenant, User}
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "credentials" do

    field :auth_type, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string  

    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id

    timestamps()
  end

  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:auth_type, :email, :password_hash])
    |> validate_required([:auth_type, :email, :password_hash])
    |> unique_constraint(:email, name: :tenant_user)
    |> put_password_hash()  
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
