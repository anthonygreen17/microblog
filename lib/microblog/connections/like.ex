defmodule Microblog.Connections.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Connections.Like


  schema "likes" do
    belongs_to :from_user, Microblog.Accounts.User, foreign_key: :from_user_id
    belongs_to :to_message, Microblog.Posts.Message, foreign_key: :to_message_id

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:from_user_id, :to_message_id])
    |> validate_required([:from_user_id, :to_message_id])
  end
end
