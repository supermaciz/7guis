defmodule SevenGUIs.Repo do
  use Ecto.Repo,
    otp_app: :seven_guis,
    adapter: Ecto.Adapters.SQLite3
end
