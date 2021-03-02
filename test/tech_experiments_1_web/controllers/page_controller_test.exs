defmodule TechExperiments1Web.PageControllerTest do
  @moduledoc """
  Tests for the Page Controller
  """
  use TechExperiments1Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Multi User Map"
  end
end
