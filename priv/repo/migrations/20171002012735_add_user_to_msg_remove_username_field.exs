defmodule Microblog.Repo.Migrations.AddUserToMsgRemoveUsernameField do
  use Ecto.Migration

  def change do

  	# null: false -> dont let the field be null
  	alter table(:messages) do
  		remove :username
  		add :user_id, references(:users, on_delete: :delete_all), null: false
  	end

  end
end
