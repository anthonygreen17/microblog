defmodule MicroblogWeb.LikeView do
  use MicroblogWeb, :view
  alias MicroblogWeb.LikeView

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "like.json")}
  end

  # def render("like.json", %{like: like}) do
  #   %{id: like.id}
  # end

  def render("like.json", %{like: like}) do
    data = %{
      user_id: like.from_user_id,
      message_id: like.to_message_id,
    }
    data

    # if Ecto.assoc_loaded?(review.user) do
      # Map.put(data, :user_email, review.user.email)
    # else
      # data
    # end
  end

  # def render("review.json", %{review: review}) do
  #   data = %{
  #     id: review.id,
  #     stars: review.stars,
  #     comment: review.comment,
  #     product_id: review.product_id,
  #   }

  #   if Ecto.assoc_loaded?(review.user) do
  #     Map.put(data, :user_email, review.user.email)
  #   else
  #     data
  #   end
  # end
end
