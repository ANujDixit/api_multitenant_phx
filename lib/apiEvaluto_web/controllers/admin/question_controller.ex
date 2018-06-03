defmodule ApiEvalutoWeb.Admin.QuestionController do
  use ApiEvaluto.Controller

  alias ApiEvaluto.Library
  alias ApiEvaluto.Library.Question 

  def index(conn, _params, resource) do
    questions = Library.list_questions(resource)
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"question" => question_params}, resource) do
    with {:ok, %Question{} = question} <- Library.create_question(resource, question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", question_path(conn, :show, question))
      |> render("show.json", question: question)
    else
    x -> IO.inspect x
    end
  end

  def show(conn, %{"id" => id}, resource) do
    question = Library.get_question!(resource, id)
    render(conn, "show.json", question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}, resource) do
    question = Library.get_question!(resource, id)

    with {:ok, %Question{} = question} <- Library.update_question(resource, question, question_params) do
      render(conn, "show.json", question: question)
    end
  end

  def delete(conn, %{"id" => id}, resource) do
    question = Library.get_question!(resource, id)
    with {:ok, %Question{}} <- Library.delete_question(question) do
      conn
      |> put_status(:ok)
      |> json(%{data: %{message: "Deleted Successfully"}})
    end
  end
end
