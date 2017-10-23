defmodule Microblog.Avatar do
  use Arc.Definition
  use Arc.Ecto.Definition

  alias Microblog.Avatar

  def __storage, do: Arc.Storage.Local # Add this

  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  @versions [:original, :thumb]
  # @versions [:original]

  # Whitelist file extensions:
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:original, _file), do: :noaction

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100"}
  end

  # def transform(:original, _) do
  #   :noaction
  # end

  # Override the persisted filenames:
  # def filename(version, _) do
  #   version
  # end

  # files will be saved in /priv/static/avatars/$FILENAME, but we need to access them as
  # /avatars/$FILENAME
  def get_file_path_original(user) do
    abs_url = Avatar.url({user.avatar, user})
    split_url = String.split(abs_url, "/")
    list_length = length(split_url)
    "/avatars/" <> Enum.at(split_url, list_length - 2) <> "/" <> Enum.at(split_url, list_length - 1)
  end

  def get_file_path_thumb(user) do
    # get_file_path_original(user)
    abs_url = Avatar.url({user.avatar, user}, :thumb)
    split_url = String.split(abs_url, "/")
    list_length = length(split_url)
    "/avatars/" <> Enum.at(split_url, list_length - 2) <> "/" <> Enum.at(split_url, list_length - 1)
  end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "priv/static/avatars/#{version}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: Plug.MIME.path(file.file_name)]
  # end
end
