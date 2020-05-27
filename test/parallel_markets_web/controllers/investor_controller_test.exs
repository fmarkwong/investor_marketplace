defmodule ParallelMarketsWeb.InvestorControllerTest do
  use ParallelMarketsWeb.ConnCase

  alias ParallelMarkets.MarketPlace

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:investor) do
    {:ok, investor} = MarketPlace.create_investor(@create_attrs)
    investor
  end

  describe "index" do
    test "lists all investors", %{conn: conn} do
      conn = get(conn, Routes.investor_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Investors"
    end
  end

  describe "new investor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.investor_path(conn, :new))
      assert html_response(conn, 200) =~ "New Investor"
    end
  end

  describe "create investor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.investor_path(conn, :create), investor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.investor_path(conn, :show, id)

      conn = get(conn, Routes.investor_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Investor"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.investor_path(conn, :create), investor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Investor"
    end
  end

  describe "edit investor" do
    setup [:create_investor]

    test "renders form for editing chosen investor", %{conn: conn, investor: investor} do
      conn = get(conn, Routes.investor_path(conn, :edit, investor))
      assert html_response(conn, 200) =~ "Edit Investor"
    end
  end

  describe "update investor" do
    setup [:create_investor]

    test "redirects when data is valid", %{conn: conn, investor: investor} do
      conn = put(conn, Routes.investor_path(conn, :update, investor), investor: @update_attrs)
      assert redirected_to(conn) == Routes.investor_path(conn, :show, investor)

      conn = get(conn, Routes.investor_path(conn, :show, investor))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, investor: investor} do
      conn = put(conn, Routes.investor_path(conn, :update, investor), investor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Investor"
    end
  end

  describe "delete investor" do
    setup [:create_investor]

    test "deletes chosen investor", %{conn: conn, investor: investor} do
      conn = delete(conn, Routes.investor_path(conn, :delete, investor))
      assert redirected_to(conn) == Routes.investor_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.investor_path(conn, :show, investor))
      end
    end
  end

  defp create_investor(_) do
    investor = fixture(:investor)
    {:ok, investor: investor}
  end
end
