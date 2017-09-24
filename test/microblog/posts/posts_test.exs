defmodule Microblog.PostsTest do
  use Microblog.DataCase

  alias Microblog.Posts

  describe "messages" do
    alias Microblog.Posts.Message

    @valid_attrs %{body: "some body", username: "some username"}
    @update_attrs %{body: "some updated body", username: "some updated username"}
    @invalid_attrs %{body: nil, username: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Posts.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Posts.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Posts.create_message(@valid_attrs)
      assert message.body == "some body"
      assert message.username == "some username"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Posts.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.body == "some updated body"
      assert message.username == "some updated username"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_message(message, @invalid_attrs)
      assert message == Posts.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Posts.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Posts.change_message(message)
    end
  end
end
