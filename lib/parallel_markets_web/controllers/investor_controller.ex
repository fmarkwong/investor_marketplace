defmodule ParallelMarketsWeb.InvestorController do
  use ParallelMarketsWeb, :controller

  alias ParallelMarkets.Documents
  alias ParallelMarkets.MarketPlace
  alias ParallelMarkets.MarketPlace.Investor

  def index(conn, _params) do
    investors = MarketPlace.list_investors()
    render(conn, "index.html", investors: investors)
  end

  def new(conn, _params) do
    changeset = MarketPlace.change_investor(%Investor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"investor" => investor_params}) do
    case MarketPlace.create_investor(investor_params) do
      {:ok, investor} ->
        IO.puts(inspect(investor_params))

        case Documents.create_upload(investor_params["upload"], investor.user) do
          {:ok, _upload} ->
            changeset = MarketPlace.change_investor(%Investor{})

            conn
            |> put_flash(:info, "Investor created successfully.")
            |> render("new.html", changeset: changeset)

          {:error, reason} ->
            changeset = Investor.changeset(%Investor{}, investor_params)

            conn
            |> put_flash(:error, "Error: #{inspect(reason)}")
            |> render("new.html", changeset: changeset)
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    investor = MarketPlace.get_investor!(id)
    render(conn, "show.html", investor: investor)
  end

  def edit(conn, %{"id" => id}) do
    investor = MarketPlace.get_investor!(id)
    changeset = MarketPlace.change_investor(investor)
    render(conn, "edit.html", investor: investor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "investor" => investor_params}) do
    investor = MarketPlace.get_investor!(id)

    case MarketPlace.update_investor(investor, investor_params) do
      {:ok, investor} ->
        conn
        |> put_flash(:info, "Investor updated successfully.")
        |> redirect(to: Routes.investor_path(conn, :show, investor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", investor: investor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    investor = MarketPlace.get_investor!(id)
    {:ok, _investor} = MarketPlace.delete_investor(investor)

    conn
    |> put_flash(:info, "Investor deleted successfully.")
    |> redirect(to: Routes.investor_path(conn, :index))
  end
end
