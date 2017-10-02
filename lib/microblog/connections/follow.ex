defmodule Microblog.Connections.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Connections.Follow


  schema "follows" do

    field :from_user_id, :integer
    field :to_user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [])
    |> validate_required([])
  end
end
