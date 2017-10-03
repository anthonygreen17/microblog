defmodule MicroblogWeb.FollowController do
  use MicroblogWeb, :controller

  alias Microblog.Connections
  alias Microblog.Connections.Follow

  def index(conn, _params) do
    follows = Connections.list_follows()
    render(conn, "index.html", follows: follows)
  end

  def new(conn, _params) do
    changeset = Connections.change_follow(%Follow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"follow" => follow_params}) do
    case Connections.create_follow(follow_params) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "Successfully followed user.")
        # |> redirect(to: follow_path(conn, :show, follow))
        |> redirect(to: NavigationHistory.last_path(conn))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    follow = Connections.get_follow!(id)
    # require IEx; IEx.pry
    render(conn, "show.html", follow: follow)
  end

  def edit(conn, %{"id" => id}) do
    follow = Connections.get_follow!(id)
    changeset = Connections.change_follow(follow)
    render(conn, "edit.html", follow: follow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "follow" => follow_params}) do
    follow = Connections.get_follow!(id)

    case Connections.update_follow(follow, follow_params) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "Follow updated successfully.")
        |> redirect(to: follow_path(conn, :show, follow))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", follow: follow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    follow = Connections.get_follow!(id)
    {:ok, _follow} = Connections.delete_follow(follow)

    conn
    |> put_flash(:info, "Successfully unfollowed user.")
    |> redirect(to: NavigationHistory.last_path(conn))
    # |> redirect(to: follow_path(conn, :index))
  end
end
