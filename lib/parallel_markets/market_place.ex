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
    # TODO: if required user attrs are missing, this will
    # return an error tuple with %User changeset which requires some hackiness with InvestorController#create
    # to fix, we need to somehow convert the User error changset
    # to an Investor error changeset
    with {:ok, user} <- Accounts.create_user(attrs) do
      %Investor{}
      |> Investor.changeset(attrs)
      |> Changeset.put_assoc(:user, user)
      |> Repo.insert()
    end
  end

  def change_investor(%Investor{} = investor, %{} = attrs \\ %{}) do
    Investor.changeset(investor, attrs)
  end
end
