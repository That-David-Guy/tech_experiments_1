defmodule TechExperiments1Web.PageLiveTest do
  use TechExperiments1Web.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Tech Experiments"
    assert render(page_live) =~ "Tech Experiments"
  end
end
