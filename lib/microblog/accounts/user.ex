defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User


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

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :is_admin?,    
                    :password, :password_confirmation])
    # comes from Comeonin??
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_password_hash()
    |> validate_required([:email, :username, :password_hash])
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

  def get_and_auth_user(email, password) do
    user = Accounts.get_user_by_email(email)
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
