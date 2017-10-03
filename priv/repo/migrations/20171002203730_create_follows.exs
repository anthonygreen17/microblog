defmodule Microblog.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :from_user_id, :integer
      add :to_user_id,   :integer

      timestamps()
    end

    create index(:follows, [:from_user_id])
    create index(:follows, [:to_user_id])
  end
end
