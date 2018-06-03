defmodule ApiEvalutoWeb.Admin.QuestionView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.Admin.QuestionView

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{id: question.id,
      title: question.title,
      type: question.type,
      explanation: question.explanation,
      choices: render_many(question.choices, __MODULE__, "choice.json", as: :choice)}
  end
  
  def render("choice.json", %{choice: choice}) do
    %{id: choice.id,
      title: choice.title,
      seq: choice.seq,
      is_correct: choice.is_correct    
    }
  end
  
end
