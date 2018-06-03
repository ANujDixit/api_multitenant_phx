defmodule ApiEvaluto.Library.Choice do
  use ApiEvaluto.Schema  
  alias ApiEvaluto.Library.Question
  alias ApiEvaluto.Accounts.User

  schema "choices" do
    field :is_correct, :boolean, default: false
    field :seq, :integer
    field :title, :string
    field :delete, :boolean, virtual: true
  
    belongs_to :tenant, Tenant, foreign_key: :tenant_id, type: :binary_id
    belongs_to :question, Question, foreign_key: :question_id, type: :binary_id
 
    timestamps()
  end
  
  def changeset(choice, attrs, tenant) do      
    choice
    |> cast(attrs, [:title, :delete, :is_correct, :seq])
    |> put_assoc(:tenant, tenant)
    |> validate_required([:title, :seq])
    |> mark_for_deletion()
  end

  defp mark_for_deletion(changeset) do  
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end

end
