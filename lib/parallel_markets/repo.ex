defmodule ParallelMarkets.Repo do
  use Ecto.Repo,
    otp_app: :parallel_markets,
    adapter: Ecto.Adapters.Postgres
end
