defmodule ApiEvaluto.Library.Question do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Accounts.User
  alias ApiEvaluto.Library.Choice

  schema "questions" do
    field :explanation, :string
    field :title, :string
    field :type, :integer
    
    has_many :choices, Choice
    
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id
    belongs_to :created_by_user, User, foreign_key: :created_by_id, type: :binary_id
    belongs_to :updated_by_user, User, foreign_key: :updated_by_id, type: :binary_id

    timestamps()
  end

  def changeset(question, attrs, tenant) do    
    question
    |> cast(attrs, [:title, :type, :explanation])
    |> validate_required([:title, :type])
    |> unique_constraint(:title, name: :tenant_question_title)
    |> cast_assoc(:choices, with: &ApiEvaluto.Library.Choice.changeset(&1, &2, tenant))
  end
  
  def changeset(question, attrs) do    
    question
    |> cast(attrs, [:title, :type, :explanation])
    |> validate_required([:title, :type])
    |> unique_constraint(:title, name: :tenant_question_title)
    |> cast_assoc(:choices)
  end

end
