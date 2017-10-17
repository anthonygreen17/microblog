defmodule MicroblogWeb.LiveFeedChannel do
  use MicroblogWeb, :channel

  alias Microblog.Posts
  alias Microblog.Accounts
  alias Microblog.Connections

  def get_channels_to_post(posting_user_id) do
    follows = Connections.get_follows_to_user(posting_user_id)
    user_ids = Enum.map(follows, fn(f)-> f.from_user_id end)
    Enum.map(user_ids, fn(i) -> (["live_feed:update:", to_string(i)]) |> Enum.join("") end)
  end

  # add the message timestamp as well as the username to the message, extract those
  # fields into a map, send the payload
  def broadcast_new_post(msg) do
    payload = Map.take(msg, [:id, :user_id, :updated_at, :body])
    payload = Map.put(payload, :username, Accounts.get_user_by_id!(msg.user_id).username)
    payload = Map.put(payload, :timestamp, Posts.get_message_timestamp(msg))
    MicroblogWeb.Endpoint.broadcast("live_feed:update", "new_post", payload)

    Enum.map(get_channels_to_post(msg.user_id), fn(chan_name) -> 
      MicroblogWeb.Endpoint.broadcast(chan_name, "new_post", payload) end)
  end

  def join("live_feed:update" <> user_id, payload, socket) do

    if authorized?(payload) do
      # socket = assign(socket, :user_id, Map.get(payload, "user_id"))
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # When a new message is posted, broadcast the message.id and message.user_id
  # so clients can decide whether or not to render the message
  def handle_in("new_post", %{"user_id" => user_id}, socket) do

    # require IEx; IEx.pry
    # notify each joined client on this socket's topic and invoke their
    # handle_out() callbacks. By default, this callback passes the broadcast on
    # t the client. but we can modify it for message filtering
    broadcast! socket, "new_post", %{user_id: user_id}
    {:noreply, socket}
  end

  # def handle_out(thing1, thing2, thing3) do
  #   require IEx; IEx.pry
    
  # end

  # intercept ["new_post"]

  # def handle_out("new_post", params, socket) do
  #   user_id = params.user_id

  #   require IEx; IEx.pry
  #   if !Microblog.Connections.user_is_following_user?(:current_user.id, user_id) do
  #     {:noreply, socket}
  #   else
  #     # get the latest message from the other user
  #     # all_msgs = Repo.get_by(Message, user_id: user_id)
  #     # last_msg = List.last all_msgs
  #     # push socket, "new_post", last_msg
  #     push socket, "new_post", user_id
  #   end
  # end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (live_feed:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(payload) do
    Map.has_key?(payload, "user_id")
  end
end
