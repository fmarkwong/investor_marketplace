defmodule ParallelMarkets.Accounts do
  @moduledoc """
  The MarketPlace context.
  """

  import Ecto.Query, warn: false
  alias ParallelMarkets.Repo

  alias ParallelMarkets.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
