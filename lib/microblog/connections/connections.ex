defmodule Microblog.Connections do
  @moduledoc """
  The Connections context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Connections.Follow

  @doc """
  Returns the list of follows.

  ## Examples

      iex> list_follows()
      [%Follow{}, ...]

  """
  def list_follows do
    Repo.all(Follow)
  end

  @doc """
  Gets a single follow.

  Raises `Ecto.NoResultsError` if the Follow does not exist.

  ## Examples

      iex> get_follow!(123)
      %Follow{}

      iex> get_follow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follow!(id), do: Repo.get!(Follow, id)

  @doc """
  Creates a follow.

  ## Examples

      iex> create_follow(%{field: value})
      {:ok, %Follow{}}

      iex> create_follow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follow(attrs \\ %{}) do
    %Follow{}
    |> Follow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a follow.

  ## Examples

      iex> update_follow(follow, %{field: new_value})
      {:ok, %Follow{}}

      iex> update_follow(follow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follow(%Follow{} = follow, attrs) do
    follow
    |> Follow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follow.

  ## Examples

      iex> delete_follow(follow)
      {:ok, %Follow{}}

      iex> delete_follow(follow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follow changes.

  ## Examples

      iex> change_follow(follow)
      %Ecto.Changeset{source: %Follow{}}

  """
  def change_follow(%Follow{} = follow) do
    Follow.changeset(follow, %{})
  end

  def user_is_following_user?(user_from, user_to) do
    Repo.get_by(Follow, from_user_id: user_from, to_user_id: user_to)
  end

  def get_follow_user_to_user!(user_from, user_to) do
    Repo.get_by(Follow, from_user_id: user_from, to_user_id: user_to)
  end


  alias Microblog.Connections.Like

  @doc """
  Returns the list of likes.

  ## Examples

      iex> list_likes()
      [%Like{}, ...]

  """
  def list_likes do
    Repo.all(Like)
  end

  @doc """
  Gets a single like.

  Raises `Ecto.NoResultsError` if the Like does not exist.

  ## Examples

      iex> get_like!(123)
      %Like{}

      iex> get_like!(456)
      ** (Ecto.NoResultsError)

  """
  def get_like!(id), do: Repo.get!(Like, id)

  @doc """
  Creates a like.

  ## Examples

      iex> create_like(%{field: value})
      {:ok, %Like{}}

      iex> create_like(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_like(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a like.

  ## Examples

      iex> update_like(like, %{field: new_value})
      {:ok, %Like{}}

      iex> update_like(like, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_like(%Like{} = like, attrs) do
    like
    |> Like.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Like.

  ## Examples

      iex> delete_like(like)
      {:ok, %Like{}}

      iex> delete_like(like)
      {:error, %Ecto.Changeset{}}

  """
  def delete_like(%Like{} = like) do
    Repo.delete(like)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking like changes.

  ## Examples

      iex> change_like(like)
      %Ecto.Changeset{source: %Like{}}

  """
  def change_like(%Like{} = like) do
    Like.changeset(like, %{})
  end

  @doc """
  Return a list of all of the likes associated with this message. If there are none,
  return the empty list.

  """
  def get_list_of_likes(message_id) do
    res = Repo.get_by(Like, to_message_id: message_id)
    case res do
      nil -> []
      true -> res
    end
  end

  @doc """
  If the user likes the post with the given id, return that like. Otherwise, return nil.

  """
  def get_user_like_on_post(user_id, message_id) do
    Repo.get_by(Like, from_user_id: user_id, to_message_id: message_id)
  end

  def get_number_of_likes(message_id) do
    res = Repo.get_by(Like, to_message_id: message_id)
    case res do
      nil -> 0
      true -> length res
    end
  end

  def user_likes_post?(user_id, message_id) do
    result = Repo.get_by(Like, from_user_id: user_id, to_message_id: message_id)
    case result do
      nil -> false
      true -> result
    end
  end

end
