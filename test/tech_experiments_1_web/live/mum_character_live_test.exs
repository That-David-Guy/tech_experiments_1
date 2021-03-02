defmodule TechExperiments1Web.MUMCharacterLiveTest do
  use TechExperiments1Web.ConnCase

  import Phoenix.LiveViewTest

  alias TechExperiments1.MUM

  @create_attrs %{graphic: "some graphic", position_x: 42, position_y: 42}
  @update_attrs %{graphic: "some updated graphic", position_x: 43, position_y: 43}
  @invalid_attrs %{graphic: nil, position_x: nil, position_y: nil}

  defp fixture(:mum_character) do
    {:ok, mum_character} = MUM.create_mum_character(@create_attrs)
    mum_character
  end

  defp create_mum_character(_) do
    mum_character = fixture(:mum_character)
    %{mum_character: mum_character}
  end

  describe "Index" do
    setup [:create_mum_character]

    test "lists all mum_characters", %{conn: conn, mum_character: mum_character} do
      {:ok, _index_live, html} = live(conn, Routes.mum_character_index_path(conn, :index))

      assert html =~ "Listing Mum characters"
      assert html =~ mum_character.graphic
    end

    test "saves new mum_character", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.mum_character_index_path(conn, :index))

      assert index_live |> element("a", "New Mum character") |> render_click() =~
               "New Mum character"

      assert_patch(index_live, Routes.mum_character_index_path(conn, :new))

      assert index_live
             |> form("#mum_character-form", mum_character: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mum_character-form", mum_character: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mum_character_index_path(conn, :index))

      assert html =~ "Mum character created successfully"
      assert html =~ "some graphic"
    end

    test "updates mum_character in listing", %{conn: conn, mum_character: mum_character} do
      {:ok, index_live, _html} = live(conn, Routes.mum_character_index_path(conn, :index))

      assert index_live |> element("#mum_character-#{mum_character.id} a", "Edit") |> render_click() =~
               "Edit Mum character"

      assert_patch(index_live, Routes.mum_character_index_path(conn, :edit, mum_character))

      assert index_live
             |> form("#mum_character-form", mum_character: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mum_character-form", mum_character: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mum_character_index_path(conn, :index))

      assert html =~ "Mum character updated successfully"
      assert html =~ "some updated graphic"
    end

    test "deletes mum_character in listing", %{conn: conn, mum_character: mum_character} do
      {:ok, index_live, _html} = live(conn, Routes.mum_character_index_path(conn, :index))

      assert index_live |> element("#mum_character-#{mum_character.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mum_character-#{mum_character.id}")
    end
  end

  describe "Show" do
    setup [:create_mum_character]

    test "displays mum_character", %{conn: conn, mum_character: mum_character} do
      {:ok, _show_live, html} = live(conn, Routes.mum_character_show_path(conn, :show, mum_character))

      assert html =~ "Show Mum character"
      assert html =~ mum_character.graphic
    end

    test "updates mum_character within modal", %{conn: conn, mum_character: mum_character} do
      {:ok, show_live, _html} = live(conn, Routes.mum_character_show_path(conn, :show, mum_character))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mum character"

      assert_patch(show_live, Routes.mum_character_show_path(conn, :edit, mum_character))

      assert show_live
             |> form("#mum_character-form", mum_character: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#mum_character-form", mum_character: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mum_character_show_path(conn, :show, mum_character))

      assert html =~ "Mum character updated successfully"
      assert html =~ "some updated graphic"
    end
  end
end
