defmodule TechExperiments1Web.PageController do
  use TechExperiments1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
