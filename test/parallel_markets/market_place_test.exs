defmodule ParallelMarkets.MarketPlaceTest do
  use ParallelMarkets.DataCase

  alias ParallelMarkets.MarketPlace

  describe "investors" do
    alias ParallelMarkets.MarketPlace.Investor

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def investor_fixture(attrs \\ %{}) do
      {:ok, investor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MarketPlace.create_investor()

      investor
    end

    test "list_investors/0 returns all investors" do
      investor = investor_fixture()
      assert MarketPlace.list_investors() == [investor]
    end

    test "get_investor!/1 returns the investor with given id" do
      investor = investor_fixture()
      assert MarketPlace.get_investor!(investor.id) == investor
    end

    test "create_investor/1 with valid data creates a investor" do
      assert {:ok, %Investor{} = investor} = MarketPlace.create_investor(@valid_attrs)
    end

    test "create_investor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MarketPlace.create_investor(@invalid_attrs)
    end

    test "update_investor/2 with valid data updates the investor" do
      investor = investor_fixture()
      assert {:ok, %Investor{} = investor} = MarketPlace.update_investor(investor, @update_attrs)
    end

    test "update_investor/2 with invalid data returns error changeset" do
      investor = investor_fixture()
      assert {:error, %Ecto.Changeset{}} = MarketPlace.update_investor(investor, @invalid_attrs)
      assert investor == MarketPlace.get_investor!(investor.id)
    end

    test "delete_investor/1 deletes the investor" do
      investor = investor_fixture()
      assert {:ok, %Investor{}} = MarketPlace.delete_investor(investor)
      assert_raise Ecto.NoResultsError, fn -> MarketPlace.get_investor!(investor.id) end
    end

    test "change_investor/1 returns a investor changeset" do
      investor = investor_fixture()
      assert %Ecto.Changeset{} = MarketPlace.change_investor(investor)
    end
  end
end
