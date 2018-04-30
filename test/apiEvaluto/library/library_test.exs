defmodule ApiEvaluto.LibraryTest do
  use ApiEvaluto.DataCase

  alias ApiEvaluto.Library

  describe "questions" do
    alias ApiEvaluto.Library.Question

    @valid_attrs %{explanation: "some explanation", title: "some title", type: 42}
    @update_attrs %{explanation: "some updated explanation", title: "some updated title", type: 43}
    @invalid_attrs %{explanation: nil, title: nil, type: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Library.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Library.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Library.create_question(@valid_attrs)
      assert question.explanation == "some explanation"
      assert question.title == "some title"
      assert question.type == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, question} = Library.update_question(question, @update_attrs)
      assert %Question{} = question
      assert question.explanation == "some updated explanation"
      assert question.title == "some updated title"
      assert question.type == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_question(question, @invalid_attrs)
      assert question == Library.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Library.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Library.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Library.change_question(question)
    end
  end
end
