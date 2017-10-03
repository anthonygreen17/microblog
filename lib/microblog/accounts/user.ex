defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User


  schema "users" do
    field :email, :string
    field :username, :string
    has_many :messages, Microblog.Posts.Message
    has_many :followed_users, Microblog.Connections.Follow, foreign_key: :from_user_id

    timestamps()
  end

  # @required_fields ~w(email)
  # @optional_fields ~w(username)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :followed_users, :messages])
    |> validate_required([:email, :username])
  end
end
