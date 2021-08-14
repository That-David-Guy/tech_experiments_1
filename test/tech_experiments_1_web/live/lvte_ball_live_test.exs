defmodule TechExperiments1Web.LVTEBallLiveTest do
  use TechExperiments1Web.ConnCase

  import Phoenix.LiveViewTest

  alias TechExperiments1.LVTE

  @create_attrs %{color: "some color", size: "some size"}
  @update_attrs %{color: "some updated color", size: "some updated size"}
  @invalid_attrs %{color: nil, size: nil}

  defp fixture(:lvte_ball) do
    {:ok, lvte_ball} = LVTE.create_lvte_ball(@create_attrs)
    lvte_ball
  end

  defp create_lvte_ball(_) do
    lvte_ball = fixture(:lvte_ball)
    %{lvte_ball: lvte_ball}
  end

  describe "Index" do
    setup [:create_lvte_ball]

    test "lists all lvte_balls", %{conn: conn, lvte_ball: lvte_ball} do
      {:ok, _index_live, html} = live(conn, Routes.lvte_ball_index_path(conn, :index))

      assert html =~ "Listing Lvte balls"
      assert html =~ lvte_ball.color
    end

    test "saves new lvte_ball", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.lvte_ball_index_path(conn, :index))

      assert index_live |> element("a", "New Lvte ball") |> render_click() =~
               "New Lvte ball"

      assert_patch(index_live, Routes.lvte_ball_index_path(conn, :new))

      assert index_live
             |> form("#lvte_ball-form", lvte_ball: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#lvte_ball-form", lvte_ball: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lvte_ball_index_path(conn, :index))

      assert html =~ "Lvte ball created successfully"
      assert html =~ "some color"
    end

    test "updates lvte_ball in listing", %{conn: conn, lvte_ball: lvte_ball} do
      {:ok, index_live, _html} = live(conn, Routes.lvte_ball_index_path(conn, :index))

      assert index_live |> element("#lvte_ball-#{lvte_ball.id} a", "Edit") |> render_click() =~
               "Edit Lvte ball"

      assert_patch(index_live, Routes.lvte_ball_index_path(conn, :edit, lvte_ball))

      assert index_live
             |> form("#lvte_ball-form", lvte_ball: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#lvte_ball-form", lvte_ball: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lvte_ball_index_path(conn, :index))

      assert html =~ "Lvte ball updated successfully"
      assert html =~ "some updated color"
    end

    test "deletes lvte_ball in listing", %{conn: conn, lvte_ball: lvte_ball} do
      {:ok, index_live, _html} = live(conn, Routes.lvte_ball_index_path(conn, :index))

      assert index_live |> element("#lvte_ball-#{lvte_ball.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#lvte_ball-#{lvte_ball.id}")
    end
  end

  describe "Show" do
    setup [:create_lvte_ball]

    test "displays lvte_ball", %{conn: conn, lvte_ball: lvte_ball} do
      {:ok, _show_live, html} = live(conn, Routes.lvte_ball_show_path(conn, :show, lvte_ball))

      assert html =~ "Show Lvte ball"
      assert html =~ lvte_ball.color
    end

    test "updates lvte_ball within modal", %{conn: conn, lvte_ball: lvte_ball} do
      {:ok, show_live, _html} = live(conn, Routes.lvte_ball_show_path(conn, :show, lvte_ball))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Lvte ball"

      assert_patch(show_live, Routes.lvte_ball_show_path(conn, :edit, lvte_ball))

      assert show_live
             |> form("#lvte_ball-form", lvte_ball: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#lvte_ball-form", lvte_ball: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lvte_ball_show_path(conn, :show, lvte_ball))

      assert html =~ "Lvte ball updated successfully"
      assert html =~ "some updated color"
    end
  end
end
