defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts.User

#   def login(conn, params) do
#   require IEx; IEx.pry
# end

  # Allow users to login with either their email or their username

  # does the "user" map need to be here? or can we pattern match the inner map...
  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    user = User.get_and_auth_user(email, password)
    # user_by_email = Accounts.get_user_by_email!(username_or_email)
    # user_by_username = Accounts.get_user_by_username!(username_or_email)

    cond do

      user != nil ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Logged in as #{user.username}")
        |> redirect(to: user_path(conn, :index))
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