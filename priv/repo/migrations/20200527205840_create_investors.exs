defmodule ParallelMarkets.Repo.Migrations.CreateInvestors do
  use Ecto.Migration

  def change do
    create table(:investors) do
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:investors, [:user_id])
  end
end
