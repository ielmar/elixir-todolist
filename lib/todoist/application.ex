defmodule Todoist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # Run migrations
    Todoist.Release.migrate()

    children = [
      # Start the Ecto repository
      Todoist.Repo,
      # Start the Telemetry supervisor
      TodoistWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Todoist.PubSub},
      # Start the Endpoint (http/https)
      TodoistWeb.Endpoint
      # Start a worker by calling: Todoist.Worker.start_link(arg)
      # {Todoist.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todoist.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodoistWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
