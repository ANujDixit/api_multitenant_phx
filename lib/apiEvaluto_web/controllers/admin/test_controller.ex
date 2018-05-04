defmodule ApiEvalutoWeb.Admin.TestController do
  use ApiEvaluto.Controller

  alias ApiEvaluto.QuizAPP
  alias ApiEvaluto.QuizAPP.Test

  def index(conn, _params, resource) do
    tests = QuizAPP.list_tests(resource)
    render(conn, "index.json", tests: tests)
  end

  def create(conn, %{"test" => test_params}, resource) do
    with {:ok, %Test{} = test} <- QuizAPP.create_test(resource, test_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", test_path(conn, :show, test))
      |> render("show.json", test: test)
    end
  end

  def show(conn, %{"id" => id}, resource) do
    test = QuizAPP.get_test!(resource, id)
    render(conn, "show.json", test: test)
  end

  def update(conn, %{"id" => id, "test" => test_params}, resource) do
    test = QuizAPP.get_test!(resource, id)

    with {:ok, %Test{} = test} <- QuizAPP.update_test(test, test_params) do
      render(conn, "show.json", test: test)
    end
  end

  def delete(conn, %{"id" => id}, resource) do
    test = QuizAPP.get_test!(resource, id)
    with {:ok, %Test{}} <- QuizAPP.delete_test(test) do
      send_resp(conn, :no_content, "")
    end
  end
end
