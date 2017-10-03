defmodule Microblog.Repo.Migrations.RemoveDefaultFollowId do
  use Ecto.Migration

  def change do

  	alter table(:follows) do
      modify :from_user_id, :integer, null: false
      modify :to_user_id,   :integer, null: false
    end

  end
end
