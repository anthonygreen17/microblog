# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Microblog.Repo.insert!(%Microblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Microblog.Posts.Message
alias Microblog.Accounts.User
alias Microblog.Repo

Repo.delete_all(Message)
Repo.delete_all(User)

Repo.insert!(%User{email: "admin@example.com", username: "agreen17"})
Repo.insert!(%User{email: "Notadmin@example.com", username: "notAdmin"})

# Accounts.create_user(%{})
