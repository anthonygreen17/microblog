defmodule Microblog.Repo.Migrations.MakeFollowsIdsNonNull do
  use Ecto.Migration

  def change do

  	alter table(:follows) do
      modify :from_user_id, :integer, null: false, default: 0
      modify :to_user_id,   :integer, null: false, default: 0
    end

  end
end
