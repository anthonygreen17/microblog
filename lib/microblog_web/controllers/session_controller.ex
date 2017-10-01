defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts

  def login(conn, %{"user" => user}) do
    user_email = Accounts.get_user_by_email!(user["email"])
    if not is_nil(user_email) do
      conn
      |> put_session(:user_id, user_email.id)
      |> put_flash(:info, "Logged in as #{user_email.email}")
      |> redirect(to: user_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "That user does not exist")
      |> redirect(to: page_path(conn, :index))
    end
  end

  # def login(conn, %{"user_or_username" => user_or_username}) do
  #   user_by_email = Accounts.get_user_by_email!(user_or_username)
  #   user_by_username = Accounts.get_user_by_username!(user_or_username)

  #   cond do

  #     user_by_email != nil ->
  #       conn
  #       |> put_session(:user_id, user_by_email.id)
  #       |> put_flash(:info, "Logged in as #{user_by_email.email}")
  #       |> redirect(to: user_path(conn, :index))

  #     user_by_username != nil ->
  #       conn
  #       |> put_session(:user_id, user_by_username.id)
  #       |> put_flash(:info, "Logged in as #{user_by_username.email}")
  #       |> redirect(to: user_path(conn, :index))

  #     true ->
  #       conn
  #       |> put_session(:user_id, nil)
  #       |> put_flash(:error, "That user does not exist")
  #       |> redirect(to: page_path(conn, :index))
  #   end
  # end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end

end