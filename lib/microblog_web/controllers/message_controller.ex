defmodule MicroblogWeb.MessageController do
  use MicroblogWeb, :controller

  alias Microblog.Posts
  alias Microblog.Posts.Message

  def index(conn, _params) do
    messages = Posts.list_messages()
    render(conn, "index.html", messages: messages)
  end

  def new(conn, _params) do
    changeset = Posts.change_message(%Message{})
    render(conn, "new.html", changeset: changeset, user_id: conn.assigns[:current_user].id)
  end

  def create(conn, %{"message" => message_params}) do
    # require IEx; IEx.pry
    case Posts.create_message(message_params) do
      {:ok, message} ->
        # cart_item = NuMart.Repo.preload(cart_item, :product)
        message = Microblog.Repo.preload(message, :user)
        # require IEx; IEx.pry
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Posts.get_message!(id) |> Microblog.Repo.preload([:user])
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Posts.get_message!(id)
    changeset = Posts.change_message(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Posts.get_message!(id)

    case Posts.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Posts.get_message!(id)
    {:ok, _message} = Posts.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: NavigationHistory.last_path(conn))
  end
end
