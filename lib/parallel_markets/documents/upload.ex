defmodule ParallelMarkets.Documents.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploads" do
    field :content_type, :string
    field :filename, :string
    field :size, :integer
    belongs_to :user, ParallelMarkets.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:filename, :size, :content_type])
    |> validate_required([:filename, :size, :content_type])
  end

  def local_path(user_id, filename) do
    [upload_directory(), "user_id_#{user_id}-#{filename}"]
    |> Path.join()
  end

  defp upload_directory do
    Application.get_env(:parallel_markets, :uploads_directory)
  end
end
