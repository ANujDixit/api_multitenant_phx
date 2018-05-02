defmodule ApiEvaluto.Accounts.Tenant do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Repo
  alias ApiEvaluto.Accounts.{Tenant, User, Group, Membership, Credential}
  alias ApiEvaluto.Authorization.{Role, AccessKey}
  alias ApiEvaluto.Library.Question
  
  schema "tenants" do
    field :code, :string
    field :name, :string
    field :slug, :string
    field :verified, :boolean
    field :active, :boolean
    
    has_many :users, User
    has_many :groups, Group
    has_many :memberships, Membership
    has_many :credentials, Credential
    has_many :roles, Role
    has_many :access_keys, AccessKey
    
    has_many :questions, Question

    timestamps()
  end

  def changeset(tenant, attrs) do
    tenant
    |> cast(attrs, [:name, :verified, :active])
    |> validate_required([:name])
    |> slugify_name() 
    |> auto_populate_company_code()
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:code)
  end
  
  defp slugify_name(changeset) do
    if name = get_change(changeset, :name), do: put_change(changeset, :slug, Slugger.slugify(name)) , else: changeset
  end
  
  defp auto_populate_company_code(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->  put_change(changeset, :code, gen_random_unique())
      _ ->  changeset
    end
  end
  
  def gen_random_unique() do
    unique = (:rand.uniform(1_000_000) - 1) |> Integer.to_string() |> String.pad_leading(6, ["0"])
    case Repo.get_by(Tenant, code: unique) do
      nil ->  unique
      _   ->  gen_random_unique()
    end
  end

end
