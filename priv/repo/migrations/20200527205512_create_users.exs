defmodule ParallelMarkets.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :dob, :date
      add :phone, :string
      add :address, :string
      add :state, :string
      add :zip, :string

      timestamps()
    end
  end
end
