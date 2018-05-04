defmodule ApiEvaluto.QuizAPPTest do
  use ApiEvaluto.DataCase

  alias ApiEvaluto.QuizAPP

  describe "tests" do
    alias ApiEvaluto.QuizAPP.Test

    @valid_attrs %{instructions: "some instructions", negative_marking: true, title: "some title", total_marks: "some total_marks"}
    @update_attrs %{instructions: "some updated instructions", negative_marking: false, title: "some updated title", total_marks: "some updated total_marks"}
    @invalid_attrs %{instructions: nil, negative_marking: nil, title: nil, total_marks: nil}

    def test_fixture(attrs \\ %{}) do
      {:ok, test} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QuizAPP.create_test()

      test
    end

    test "list_tests/0 returns all tests" do
      test = test_fixture()
      assert QuizAPP.list_tests() == [test]
    end

    test "get_test!/1 returns the test with given id" do
      test = test_fixture()
      assert QuizAPP.get_test!(test.id) == test
    end

    test "create_test/1 with valid data creates a test" do
      assert {:ok, %Test{} = test} = QuizAPP.create_test(@valid_attrs)
      assert test.instructions == "some instructions"
      assert test.negative_marking == true
      assert test.title == "some title"
      assert test.total_marks == "some total_marks"
    end

    test "create_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QuizAPP.create_test(@invalid_attrs)
    end

    test "update_test/2 with valid data updates the test" do
      test = test_fixture()
      assert {:ok, test} = QuizAPP.update_test(test, @update_attrs)
      assert %Test{} = test
      assert test.instructions == "some updated instructions"
      assert test.negative_marking == false
      assert test.title == "some updated title"
      assert test.total_marks == "some updated total_marks"
    end

    test "update_test/2 with invalid data returns error changeset" do
      test = test_fixture()
      assert {:error, %Ecto.Changeset{}} = QuizAPP.update_test(test, @invalid_attrs)
      assert test == QuizAPP.get_test!(test.id)
    end

    test "delete_test/1 deletes the test" do
      test = test_fixture()
      assert {:ok, %Test{}} = QuizAPP.delete_test(test)
      assert_raise Ecto.NoResultsError, fn -> QuizAPP.get_test!(test.id) end
    end

    test "change_test/1 returns a test changeset" do
      test = test_fixture()
      assert %Ecto.Changeset{} = QuizAPP.change_test(test)
    end
  end
end
