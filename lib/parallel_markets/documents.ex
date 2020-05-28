defmodule ParallelMarkets.Documents do
  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias ParallelMarkets.Repo
  alias ParallelMarkets.Documents.Upload
  alias ParallelMarkets.Accounts.User

  def create_upload(
        %Plug.Upload{
          filename: filename,
          path: tmp_path,
          content_type: content_type
        },
        %User{} = user
      ) do
    Repo.transaction(fn ->
      with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path),
           {:ok, upload} <- do_create_upload(filename, content_type, size, user),
           :ok <- copy_file(filename, tmp_path, user) do
        {:ok, upload}
      else
        {:error, reason} ->
          Repo.rollback(reason)
      end
    end)
  end

  def create_upload(nil, _user), do: {:error, "Please choose a file to upload."}

  defp do_create_upload(filename, content_type, size, user) do
    %Upload{}
    |> Upload.changeset(%{
      filename: filename,
      content_type: content_type,
      size: size
    })
    |> Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  defp copy_file(filename, tmp_path, user) do
    File.cp(tmp_path, Upload.local_path(user.id, filename))
  end
end
