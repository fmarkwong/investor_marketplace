defmodule ParallelMarketsWeb.InvestorController do
  use ParallelMarketsWeb, :controller

  alias ParallelMarkets.Documents
  alias ParallelMarkets.MarketPlace
  alias ParallelMarkets.MarketPlace.Investor

  def new(conn, _params) do
    changeset = MarketPlace.change_investor(%Investor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"investor" => investor_params}) do
    case MarketPlace.create_investor(investor_params) do
      {:ok, investor} ->

        case Documents.create_upload(investor_params["upload"], investor.user) do
          {:ok, _upload} ->
            changeset = MarketPlace.change_investor(%Investor{})

            conn
            |> put_flash(:info, "Investor created successfully.")
            |> render("new.html", changeset: changeset)

          {:error, reason} ->
            changeset = MarketPlace.change_investor(%Investor{}, investor_params)

            conn
            |> put_flash(:error, "Error: #{inspect(reason)}")
            |> render("new.html", changeset: changeset)
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  
  # TODO: this is needed because the way we're handling error reporting empty investor fields is a little wonky 
  # at Marketplace#create_investor we try to create a user with the attributes.  If the attributes are missing we return an error tuple with a %User changeset.  So the form will have a "user" subfield instead of an "investor" subfield, so we need to convert that here.
  def create(conn, %{"user" => params}), do: create(conn, %{"investor" => params})
end
