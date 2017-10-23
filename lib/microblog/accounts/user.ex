defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User

  alias Microblog.Accounts
  use Arc.Ecto.Schema

  schema "users" do
    field :email, :string
    field :username, :string
    has_many :messages, Microblog.Posts.Message
    has_many :followed_users, Microblog.Connections.Follow, foreign_key: :from_user_id
    has_many :likes, Microblog.Connections.Like, foreign_key: :from_user_id

    # schema fields taken from ntuck/nu_mart
    field :is_admin?, :boolean
    field :password_hash, :string
    field :pw_tries, :integer
    field :pw_last_try, :utc_datetime

    # virtual lets the user submit a password along with their
    # request, but its not actually stored in the DB
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true  

    field :avatar, Microblog.Avatar.Type

    timestamps()
  end

  # for arc_ecto
  @required_file_fields ~w()
  @optional_file_fields ~w(avatar)

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :is_admin?,    
                    :password, :password_confirmation, :avatar])
    |> cast_attachments(attrs, @required_file_fields, @optional_file_fields)
    # comes from Comeonin??
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_password_hash()
    |> validate_required([:email, :username, :password_hash, :avatar])
    |> unique_constraint(:email, message: "Email already taken")
  end

  # Password validation
  # From Comeonin docs
  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field,
      # run this function to validate the change
      fn _, password ->
        case valid_password?(password) do
          {:ok, _} -> []
          {:error, msg} -> [{field, options[:message] || msg}]
        end
      end
    )
  end


  @doc """
  Get a user either by username or by email. Verify their password.

  """
  def get_and_auth_user(username_or_email, password) do
    user_by_email = Accounts.get_user_by_email(username_or_email)
    user_by_username = Accounts.get_user_by_username(username_or_email)

    user = 
    cond do
      user_by_email != nil ->
        user_by_email
      user_by_username != nil ->
        user_by_username
      true ->
        nil
    end

    case Comeonin.Argon2.check_pass(user, password) do
      {:ok, user} -> user
      _else       -> nil
    end
  end

  ########################################
  # These functions were taken from ntuck's lecture notes on 10/16 - passwords/security
  ########################################


  # pattern match - We're ony interested in VALID changesets (ie: valid password)
  def put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do

    # as long as we name the 2nd virtual field "password_hash", this will work correctly
    # and update the "password_hash" field
    #
    # this actually sets password to nil and puts the hash in password_hash
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  # pattern match an invalid changeset
  def put_password_hash(changeset), do: changeset

  def valid_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end
  def valid_password?(_), do: {:error, "The password is too short"}

end
