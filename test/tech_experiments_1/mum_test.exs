defmodule TechExperiments1.MUMTest do
  use TechExperiments1.DataCase

  alias TechExperiments1.MUM

  describe "mum_characters" do
    alias TechExperiments1.MUM.MUMCharacter

    @valid_attrs %{graphic: "some graphic", position_x: 42, position_y: 42}
    @update_attrs %{graphic: "some updated graphic", position_x: 43, position_y: 43}
    @invalid_attrs %{graphic: nil, position_x: nil, position_y: nil}

    def mum_character_fixture(attrs \\ %{}) do
      {:ok, mum_character} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MUM.create_mum_character()

      mum_character
    end

    test "list_mum_characters/0 returns all mum_characters" do
      mum_character = mum_character_fixture()
      assert MUM.list_mum_characters() == [mum_character]
    end

    test "get_mum_character!/1 returns the mum_character with given id" do
      mum_character = mum_character_fixture()
      assert MUM.get_mum_character!(mum_character.id) == mum_character
    end

    test "create_mum_character/1 with valid data creates a mum_character" do
      assert {:ok, %MUMCharacter{} = mum_character} = MUM.create_mum_character(@valid_attrs)
      assert mum_character.graphic == "some graphic"
      assert mum_character.position_x == 42
      assert mum_character.position_y == 42
    end

    test "create_mum_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MUM.create_mum_character(@invalid_attrs)
    end

    test "update_mum_character/2 with valid data updates the mum_character" do
      mum_character = mum_character_fixture()
      assert {:ok, %MUMCharacter{} = mum_character} = MUM.update_mum_character(mum_character, @update_attrs)
      assert mum_character.graphic == "some updated graphic"
      assert mum_character.position_x == 43
      assert mum_character.position_y == 43
    end

    test "update_mum_character/2 with invalid data returns error changeset" do
      mum_character = mum_character_fixture()
      assert {:error, %Ecto.Changeset{}} = MUM.update_mum_character(mum_character, @invalid_attrs)
      assert mum_character == MUM.get_mum_character!(mum_character.id)
    end

    test "delete_mum_character/1 deletes the mum_character" do
      mum_character = mum_character_fixture()
      assert {:ok, %MUMCharacter{}} = MUM.delete_mum_character(mum_character)
      assert_raise Ecto.NoResultsError, fn -> MUM.get_mum_character!(mum_character.id) end
    end

    test "change_mum_character/1 returns a mum_character changeset" do
      mum_character = mum_character_fixture()
      assert %Ecto.Changeset{} = MUM.change_mum_character(mum_character)
    end
  end
end
