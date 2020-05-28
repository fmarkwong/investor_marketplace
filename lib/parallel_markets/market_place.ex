defmodule ParallelMarkets.MarketPlace do
  @moduledoc """
  The MarketPlace context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias ParallelMarkets.Repo

  alias ParallelMarkets.Accounts
  alias ParallelMarkets.MarketPlace.Investor

  @doc """
  Creates a user and its associated investor.
  """
  def create_investor(attrs \\ %{}) do
    {:ok, user} = Accounts.create_user(attrs)

    %Investor{}
    |> Investor.changeset(attrs)
    |> Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def change_investor(%Investor{} = investor, %{} = attrs \\ %{}) do
    Investor.changeset(investor, attrs)
  end
end
