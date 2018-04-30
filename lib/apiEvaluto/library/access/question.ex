defmodule ApiEvaluto.Library.Access.Question do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo
      alias ApiEvaluto.Library.Question
     
      def list_questions(tenant) do
        Question
        |> where([q], q.tenant_id == ^tenant.id)
        |> order_by(desc: :updated_at)
        |> preload(:choices)
        |> Repo.all()
      end
  
      def get_question!(tenant, id) do
        Question
        |> where([q], q.tenant_id == ^tenant.id)
        |> preload(:choices)
        |> Repo.get!(id)
      end  

      def create_question(tenant, attrs \\ %{}) do
        if attrs["choices"] == [] do
            attrs
          else 
            attrs = Map.put(attrs, "choices", attrs["choices"] |> Enum.map(fn(x) -> Map.put(x, "tenant_id", tenant.id ) end))
        end
        Ecto.build_assoc(tenant, :questions)
        |> Question.changeset(attrs)
        |> Repo.insert()
      end

      def update_question(%Question{} = question, attrs) do
        question
        |> Question.changeset(attrs)
        |> Repo.update()
      end

      def delete_question(%Question{} = question) do
        Repo.delete(question)
      end
        
    end
  end
end