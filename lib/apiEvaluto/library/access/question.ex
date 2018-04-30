defmodule ApiEvaluto.Library.Access.Question do
  defmacro __using__(_) do
    quote do
      import Ecto.Query, warn: false
      alias ApiEvaluto.Repo
      alias ApiEvaluto.Library.Question
     
      def list_questions(resource) do
        Question
        |> where([q], q.tenant_id == ^resource.tenant.id)
        |> order_by(desc: :updated_at)
        |> preload(:choices)
        |> Repo.all()
      end
  
      def get_question!(resource, id) do
        Question
        |> where([q], q.tenant_id == ^resource.tenant.id)
        |> preload(:choices)
        |> Repo.get!(id)
      end  

      def create_question(resource, attrs \\ %{}) do
        attrs =
          case attrs["choices"] do
            [] -> attrs
            _  -> Map.put(attrs, "choices", attrs["choices"] 
                  |> Enum.map(fn(x) -> Map.put(x, "tenant_id", resource.tenant.id ) end))
          end
       
        Ecto.build_assoc(resource.tenant, :questions)
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