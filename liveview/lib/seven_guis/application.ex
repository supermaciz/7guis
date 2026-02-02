defmodule SevenGUIs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SevenGUIsWeb.Telemetry,
      SevenGUIs.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:seven_guis, :ecto_repos), skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:seven_guis, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SevenGUIs.PubSub},
      # Start a worker by calling: SevenGUIs.Worker.start_link(arg)
      # {SevenGUIs.Worker, arg},
      # Start to serve requests, typically the last entry
      SevenGUIsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SevenGUIs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SevenGUIsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") == nil
  end
end
