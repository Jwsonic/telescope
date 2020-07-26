defmodule Telescope.Repo do
  use Ecto.Repo,
    otp_app: :telescope,
    adapter: Ecto.Adapters.Postgres
end
