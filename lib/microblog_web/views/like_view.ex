defmodule MicroblogWeb.LikeView do
  use MicroblogWeb, :view
  alias MicroblogWeb.LikeView

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "like.json")}
  end

  def render("like.json", %{like: like}) do
    data = %{
      user_id: like.from_user_id,
      message_id: like.to_message_id,
    }
    data
  end

end
