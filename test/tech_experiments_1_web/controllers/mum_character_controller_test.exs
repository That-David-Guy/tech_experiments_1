defmodule TechExperiments1Web.MUMCharacterControllerTest do
  use TechExperiments1Web.ConnCase

  alias TechExperiments1.MUM

  @create_attrs %{graphic: "some graphic", position_x: 42, position_y: 42}
  @update_attrs %{graphic: "some updated graphic", position_x: 43, position_y: 43}
  @invalid_attrs %{graphic: nil, position_x: nil, position_y: nil}

  def fixture(:mum_character) do
    {:ok, mum_character} = MUM.create_mum_character(@create_attrs)
    mum_character
  end

  describe "index" do
    test "lists all mum_characters", %{conn: conn} do
      conn = get(conn, Routes.mum_character_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Mum characters"
    end
  end

  describe "new mum_character" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.mum_character_path(conn, :new))
      assert html_response(conn, 200) =~ "New Mum character"
    end
  end

  describe "create mum_character" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mum_character_path(conn, :create), mum_character: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.mum_character_path(conn, :show, id)

      conn = get(conn, Routes.mum_character_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Mum character"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mum_character_path(conn, :create), mum_character: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mum character"
    end
  end

  describe "edit mum_character" do
    setup [:create_mum_character]

    test "renders form for editing chosen mum_character", %{conn: conn, mum_character: mum_character} do
      conn = get(conn, Routes.mum_character_path(conn, :edit, mum_character))
      assert html_response(conn, 200) =~ "Edit Mum character"
    end
  end

  describe "update mum_character" do
    setup [:create_mum_character]

    test "redirects when data is valid", %{conn: conn, mum_character: mum_character} do
      conn = put(conn, Routes.mum_character_path(conn, :update, mum_character), mum_character: @update_attrs)
      assert redirected_to(conn) == Routes.mum_character_path(conn, :show, mum_character)

      conn = get(conn, Routes.mum_character_path(conn, :show, mum_character))
      assert html_response(conn, 200) =~ "some updated graphic"
    end

    test "renders errors when data is invalid", %{conn: conn, mum_character: mum_character} do
      conn = put(conn, Routes.mum_character_path(conn, :update, mum_character), mum_character: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mum character"
    end
  end

  describe "delete mum_character" do
    setup [:create_mum_character]

    test "deletes chosen mum_character", %{conn: conn, mum_character: mum_character} do
      conn = delete(conn, Routes.mum_character_path(conn, :delete, mum_character))
      assert redirected_to(conn) == Routes.mum_character_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.mum_character_path(conn, :show, mum_character))
      end
    end
  end

  defp create_mum_character(_) do
    mum_character = fixture(:mum_character)
    %{mum_character: mum_character}
  end
end
