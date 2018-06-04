defmodule ApiEvaluto.Accounts.AdminUser do
  use ApiEvaluto.Schema  
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  
  schema "admin_users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string 
    
    timestamps()
  end

  def changeset(admin_user, attrs) do
    admin_user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> put_password_hash()  
  end
  
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end
end
