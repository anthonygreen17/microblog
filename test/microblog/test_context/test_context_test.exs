defmodule Microblog.TestContextTest do
  use Microblog.DataCase

  alias Microblog.TestContext

  describe "test_resources" do
    alias Microblog.TestContext.TestResource

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def test_resource_fixture(attrs \\ %{}) do
      {:ok, test_resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TestContext.create_test_resource()

      test_resource
    end

    test "list_test_resources/0 returns all test_resources" do
      test_resource = test_resource_fixture()
      assert TestContext.list_test_resources() == [test_resource]
    end

    test "get_test_resource!/1 returns the test_resource with given id" do
      test_resource = test_resource_fixture()
      assert TestContext.get_test_resource!(test_resource.id) == test_resource
    end

    test "create_test_resource/1 with valid data creates a test_resource" do
      assert {:ok, %TestResource{} = test_resource} = TestContext.create_test_resource(@valid_attrs)
      assert test_resource.name == "some name"
    end

    test "create_test_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TestContext.create_test_resource(@invalid_attrs)
    end

    test "update_test_resource/2 with valid data updates the test_resource" do
      test_resource = test_resource_fixture()
      assert {:ok, test_resource} = TestContext.update_test_resource(test_resource, @update_attrs)
      assert %TestResource{} = test_resource
      assert test_resource.name == "some updated name"
    end

    test "update_test_resource/2 with invalid data returns error changeset" do
      test_resource = test_resource_fixture()
      assert {:error, %Ecto.Changeset{}} = TestContext.update_test_resource(test_resource, @invalid_attrs)
      assert test_resource == TestContext.get_test_resource!(test_resource.id)
    end

    test "delete_test_resource/1 deletes the test_resource" do
      test_resource = test_resource_fixture()
      assert {:ok, %TestResource{}} = TestContext.delete_test_resource(test_resource)
      assert_raise Ecto.NoResultsError, fn -> TestContext.get_test_resource!(test_resource.id) end
    end

    test "change_test_resource/1 returns a test_resource changeset" do
      test_resource = test_resource_fixture()
      assert %Ecto.Changeset{} = TestContext.change_test_resource(test_resource)
    end
  end
end
