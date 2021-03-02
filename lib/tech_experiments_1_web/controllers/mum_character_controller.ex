defmodule TechExperiments1Web.MUMCharacterController do
  use TechExperiments1Web, :controller

  alias TechExperiments1.MUM
  alias TechExperiments1.MUM.MUMCharacter

  def index(conn, _params) do
    mum_characters = MUM.list_mum_characters()
    render(conn, "index.html", mum_characters: mum_characters)
  end

  def new(conn, _params) do
    changeset = MUM.change_mum_character(%MUMCharacter{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mum_character" => mum_character_params}) do
    case MUM.create_mum_character(mum_character_params) do
      {:ok, mum_character} ->
        conn
        |> put_flash(:info, "Mum character created successfully.")
        |> redirect(to: Routes.mum_character_path(conn, :show, mum_character))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mum_character = MUM.get_mum_character!(id)
    render(conn, "show.html", mum_character: mum_character)
  end

  def edit(conn, %{"id" => id}) do
    mum_character = MUM.get_mum_character!(id)
    changeset = MUM.change_mum_character(mum_character)
    render(conn, "edit.html", mum_character: mum_character, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mum_character" => mum_character_params}) do
    mum_character = MUM.get_mum_character!(id)

    case MUM.update_mum_character(mum_character, mum_character_params) do
      {:ok, mum_character} ->
        conn
        |> put_flash(:info, "Mum character updated successfully.")
        |> redirect(to: Routes.mum_character_path(conn, :show, mum_character))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mum_character: mum_character, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mum_character = MUM.get_mum_character!(id)
    {:ok, _mum_character} = MUM.delete_mum_character(mum_character)

    conn
    |> put_flash(:info, "Mum character deleted successfully.")
    |> redirect(to: Routes.mum_character_path(conn, :index))
  end
end
