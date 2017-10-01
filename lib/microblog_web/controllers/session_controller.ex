defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts

#   def login(conn, params) do
#   require IEx; IEx.pry
# end

  # Allow users to login with either their email or their username
  def login(conn, %{"user" => %{"username_or_email" => username_or_email}}) do
    user_by_email = Accounts.get_user_by_email!(username_or_email)
    user_by_username = Accounts.get_user_by_username!(username_or_email)

    cond do

      user_by_email != nil ->
        conn
        |> put_session(:user_id, user_by_email.id)
        |> put_flash(:info, "Logged in as #{user_by_email.email}")
        |> redirect(to: user_path(conn, :index))

      user_by_username != nil ->
        conn
        |> put_session(:user_id, user_by_username.id)
        |> put_flash(:info, "Logged in as #{user_by_username.email}")
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