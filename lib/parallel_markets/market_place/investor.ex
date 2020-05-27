defmodule ParallelMarkets.MarketPlace.Investor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "investors" do
    belongs_to :user, ParallelMarkets.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(investor, attrs) do
    investor
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint(:user_id)
  end
end
