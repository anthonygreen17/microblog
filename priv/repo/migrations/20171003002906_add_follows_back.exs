defmodule Microblog.Repo.Migrations.AddFollowsBack do
  use Ecto.Migration

  def change do

  	alter table(:follows) do
      add :from_user_id, references(:users, on_delete: :delete_all)
      add :to_user_id, references(:users, on_delete: :delete_all)
    end

  end
end
