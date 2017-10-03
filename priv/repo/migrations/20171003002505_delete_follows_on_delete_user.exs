defmodule Microblog.Repo.Migrations.DeleteFollowsOnDeleteUser do
  use Ecto.Migration

  def change do

  	alter table(:follows) do
      remove :from_user_id#, references(:users, on_delete: :delete_all)
      remove :to_user_id #, references(:users, on_delete: :delete_all)
    end

  end
end
