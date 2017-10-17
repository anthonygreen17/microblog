defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts.User

#   def login(conn, params) do
#   require IEx; IEx.pry
# end

  # Allow users to login with either their email or their username

  # does the "user" map need to be here? or can we pattern match the inner map...
  def login(conn, %{"user" => %{"username_or_email" => username_or_email, "password" => password}}) do
    user = User.get_and_auth_user(username_or_email, password)

    cond do

      user != nil ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Logged in as #{user.username}")
        |> redirect(to: message_path(conn, :index))
      true ->
        conn
        |> put_session(:user_id, nil)
        |> put_flash(:error, "That user does not exist")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end

end