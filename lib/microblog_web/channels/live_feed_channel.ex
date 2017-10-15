defmodule MicroblogWeb.LiveFeedChannel do
  use MicroblogWeb, :channel

  # import Microblog.Repo
  alias Microblog.Repo

  def join("live_feed:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end

  # When a new message is posted, broadcast the message.id and message.user_id
  # so clients can decide whether or not to render the message
  def handle_in("new_post", user_id, socket) do

    # notify each joined client on this socket's topic and invoke their
    # handle_out() callbacks. By default, this callback passes the broadcast on
    # t the client. but we can modify it for message filtering
    broadcast! socket, "new_msg", user_id
    {:noreply, socket}
  end

  intercept ["new_post"]

  def handle_out("new_post", user_id, socket) do
    if !Microblog.Connections.user_is_following_user?(:current_user, user_id) do
      {:noreply, socket}
    else
      # get the latest message from the other user
      all_msgs = Repo.get_by(Message, user_id: user_id)
      last_msg = List.last all_msgs
      push socket, "new_post", last_msg
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (live_feed:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
