defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.Connections
  alias Microblog.Connections.Like

  action_fallback MicroblogWeb.FallbackController

  # This goes first.
  def index(conn, %{"from_user_id" => from_user_id, "to_message_id" => to_message_id}) do
    like = Connections.user_likes_post?(from_user_id, to_message_id)
    render(conn, "index.json", likes: like)
  end

  def index(conn, %{"to_message_id" => to_message_id}) do
    likes = Connections.get_number_of_likes(to_message_id)
    render(conn, "index.json", likes: likes)
  end

  def index(conn, _params) do
    likes = Connections.list_likes()
    render(conn, "index.json", likes: likes)
  end

  

  def create(conn, %{"like" => like_params}) do
    with {:ok, %Like{} = like} <- Connections.create_like(like_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", like_path(conn, :show, like))
      |> render("show.json", like: like)
    end
  end

  def show(conn, %{"id" => id}) do
    like = Connections.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Connections.get_like!(id)

    with {:ok, %Like{} = like} <- Connections.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Connections.get_like!(id)
    with {:ok, %Like{}} <- Connections.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end
end
