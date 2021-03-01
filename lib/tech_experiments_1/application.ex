defmodule TechExperiments1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TechExperiments1.Repo,
      # Start the Telemetry supervisor
      TechExperiments1Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TechExperiments1.PubSub},
      # Start the Endpoint (http/https)
      TechExperiments1Web.Endpoint
      # Start a worker by calling: TechExperiments1.Worker.start_link(arg)
      # {TechExperiments1.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TechExperiments1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TechExperiments1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
