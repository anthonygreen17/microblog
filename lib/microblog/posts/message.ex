defmodule Microblog.Posts.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Posts.Message


  schema "messages" do
    field :body, :string
    belongs_to :user, Microblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:user_id, :body])
    |> validate_required([:user_id, :body])
  end
end
