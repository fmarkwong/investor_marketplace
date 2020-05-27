defmodule ParallelMarkets.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :filename, :string
      add :size, :integer
      add :content_type, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:uploads, [:user_id])
  end
end
