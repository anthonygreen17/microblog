defmodule Microblog.Repo.Migrations.ChangeFollowsToReferences do
  use Ecto.Migration

  def change do

  	alter table(:follows) do
      modify :from_user_id, references(:users, on_delete: :nothing)
      modify :to_user_id, references(:users, on_delete: :nothing)
    end

  end
end
