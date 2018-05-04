defmodule ApiEvaluto.QuizAPP.Test do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Accounts.User

  schema "tests" do
    field :title, :string
    field :instructions, :string
    field :negative_marking, :boolean, default: false
    field :total_marks, :decimal, default: 0.00
    
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id
    belongs_to :created_by_user, User, foreign_key: :created_by_id, type: :binary_id
    belongs_to :updated_by_user, User, foreign_key: :updated_by_id, type: :binary_id  

    timestamps()
  end

  def changeset(test, attrs) do
    test
    |> cast(attrs, [:title, :instructions, :negative_marking, :total_marks])
    |> validate_required([:title])
  end
end
