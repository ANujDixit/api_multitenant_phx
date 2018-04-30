defmodule ApiEvalutoWeb.Admin.QuestionController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Library
  alias ApiEvaluto.Library.Question

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    questions = Library.list_questions(conn.assigns.tenant)
    render(conn, "index.json", questions: questions)
  end

  def create(conn, %{"question" => question_params}) do
    with {:ok, %Question{} = question} <- Library.create_question(conn.assigns.tenant, question_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", question_path(conn, :show, question))
      |> render("show.json", question: question)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Library.get_question!(conn.assigns.tenant, id)
    render(conn, "show.json", question: question)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Library.get_question!(conn.assigns.tenant, id)

    with {:ok, %Question{} = question} <- Library.update_question(question, question_params) do
      render(conn, "show.json", question: question)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Library.get_question!(conn.assigns.tenant, id)
    with {:ok, %Question{}} <- Library.delete_question(question) do
      send_resp(conn, :no_content, "")
    end
  end
end
