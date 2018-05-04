defmodule ApiEvalutoWeb.Admin.TestView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.Admin.TestView

  def render("index.json", %{tests: tests}) do
    %{data: render_many(tests, TestView, "test.json")}
  end

  def render("show.json", %{test: test}) do
    %{data: render_one(test, TestView, "test.json")}
  end

  def render("test.json", %{test: test}) do
    %{id: test.id,
      title: test.title,
      instructions: test.instructions,
      negative_marking: test.negative_marking,
      total_marks: test.total_marks,
      created_by: "#{test.created_by_user.first_name} #{test.created_by_user.last_name}" ,
      updated_by: "#{test.updated_by_user.first_name} #{test.updated_by_user.last_name}" 
    }
  end
end
