defmodule ApiEvaluto.Library.Access.Question do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo
      alias ApiEvaluto.Library.{Question, Choice}
     
      def list_questions(resource) do
        Question
        |> where([q], q.tenant_id == ^resource.tenant.id)
        |> order_by(desc: :updated_at)
        |> Repo.all()
        |> Repo.preload([choices: (from c in Choice, order_by: c.seq)])
      end
  
      def get_question!(resource, id) do
        Question
        |> where([q], q.tenant_id == ^resource.tenant.id)
        |> Repo.get!(id)
        |> Repo.preload([choices: (from c in Choice, order_by: c.seq)])
      end  

      def create_question(resource, attrs \\ %{}) do
        Ecto.build_assoc(resource.tenant, :questions)
        |> Question.changeset(attrs, resource.tenant)
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