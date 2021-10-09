defmodule TechExperiments1Web.Router do
  use TechExperiments1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TechExperiments1Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TechExperiments1Web do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/", TechExperiments1Web do
    pipe_through :browser

    live "/multi-user-map", MUMCharacterLive.Index, :index
    live "/mum_characters/new", MUMCharacterLive.Index, :new
    live "/mum_characters/:id/edit", MUMCharacterLive.Index, :edit

    live "/mum_characters/:id", MUMCharacterLive.Show, :show
    live "/mum_characters/:id/show/edit", MUMCharacterLive.Show, :edit
  end

  scope "/", TechExperiments1Web do
    pipe_through :browser

    live "/lvte_balls", LVTEBallLive.Index, :index
    live "/lvte_balls/new", LVTEBallLive.Index, :new
    live "/lvte_balls/:id/edit", LVTEBallLive.Index, :edit

    live "/lvte_balls/:id", LVTEBallLive.Show, :show
    live "/lvte_balls/:id/show/edit", LVTEBallLive.Show, :edit
  end

  scope "/", TechExperiments1Web do
    pipe_through :browser

    live "/tailwindcss", TailwindcssLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TechExperiments1Web do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TechExperiments1Web.Telemetry
    end
  end
end
