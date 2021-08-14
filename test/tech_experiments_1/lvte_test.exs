defmodule TechExperiments1.LVTETest do
  use TechExperiments1.DataCase

  alias TechExperiments1.LVTE

  describe "lvte_balls" do
    alias TechExperiments1.LVTE.LVTEBall

    @valid_attrs %{color: "some color", size: "some size"}
    @update_attrs %{color: "some updated color", size: "some updated size"}
    @invalid_attrs %{color: nil, size: nil}

    def lvte_ball_fixture(attrs \\ %{}) do
      {:ok, lvte_ball} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LVTE.create_lvte_ball()

      lvte_ball
    end

    test "list_lvte_balls/0 returns all lvte_balls" do
      lvte_ball = lvte_ball_fixture()
      assert LVTE.list_lvte_balls() == [lvte_ball]
    end

    test "get_lvte_ball!/1 returns the lvte_ball with given id" do
      lvte_ball = lvte_ball_fixture()
      assert LVTE.get_lvte_ball!(lvte_ball.id) == lvte_ball
    end

    test "create_lvte_ball/1 with valid data creates a lvte_ball" do
      assert {:ok, %LVTEBall{} = lvte_ball} = LVTE.create_lvte_ball(@valid_attrs)
      assert lvte_ball.color == "some color"
      assert lvte_ball.size == "some size"
    end

    test "create_lvte_ball/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LVTE.create_lvte_ball(@invalid_attrs)
    end

    test "update_lvte_ball/2 with valid data updates the lvte_ball" do
      lvte_ball = lvte_ball_fixture()
      assert {:ok, %LVTEBall{} = lvte_ball} = LVTE.update_lvte_ball(lvte_ball, @update_attrs)
      assert lvte_ball.color == "some updated color"
      assert lvte_ball.size == "some updated size"
    end

    test "update_lvte_ball/2 with invalid data returns error changeset" do
      lvte_ball = lvte_ball_fixture()
      assert {:error, %Ecto.Changeset{}} = LVTE.update_lvte_ball(lvte_ball, @invalid_attrs)
      assert lvte_ball == LVTE.get_lvte_ball!(lvte_ball.id)
    end

    test "delete_lvte_ball/1 deletes the lvte_ball" do
      lvte_ball = lvte_ball_fixture()
      assert {:ok, %LVTEBall{}} = LVTE.delete_lvte_ball(lvte_ball)
      assert_raise Ecto.NoResultsError, fn -> LVTE.get_lvte_ball!(lvte_ball.id) end
    end

    test "change_lvte_ball/1 returns a lvte_ball changeset" do
      lvte_ball = lvte_ball_fixture()
      assert %Ecto.Changeset{} = LVTE.change_lvte_ball(lvte_ball)
    end
  end
end
