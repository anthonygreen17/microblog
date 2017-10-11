defmodule Microblog.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :from_user_id, references(:users, on_delete: :nothing)
      add :to_message_id, references(:messages, on_delete: :nothing)

      timestamps()
    end

    create index(:likes, [:from_user_id])
    create index(:likes, [:to_message_id])
  end
end
