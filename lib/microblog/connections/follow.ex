defmodule Microblog.Connections.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Connections.Follow


  schema "follows" do

    belongs_to :from_user, Microblog.Accounts.User, foreign_key: :from_user_id
    belongs_to :to_user, Microblog.Accounts.User, foreign_key: :to_user_id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:from_user_id, :to_user_id])
    |> validate_required([:from_user_id, :to_user_id])
  end
end
