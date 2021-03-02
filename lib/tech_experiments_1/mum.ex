defmodule TechExperiments1.MUM do
  @moduledoc """
  The MUM context.
  """

  import Ecto.Query, warn: false
  alias TechExperiments1.Repo

  alias TechExperiments1.MUM.MUMCharacter

  @doc """
  Returns the list of mum_characters.

  ## Examples

      iex> list_mum_characters()
      [%MUMCharacter{}, ...]

  """
  def list_mum_characters do
    Repo.all(MUMCharacter)
  end

  @doc """
  Gets a single mum_character.

  Raises `Ecto.NoResultsError` if the Mum character does not exist.

  ## Examples

      iex> get_mum_character!(123)
      %MUMCharacter{}

      iex> get_mum_character!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mum_character!(id), do: Repo.get!(MUMCharacter, id)

  @doc """
  Creates a mum_character.

  ## Examples

      iex> create_mum_character(%{field: value})
      {:ok, %MUMCharacter{}}

      iex> create_mum_character(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mum_character(attrs \\ %{}) do
    %MUMCharacter{}
    |> MUMCharacter.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mum_character.

  ## Examples

      iex> update_mum_character(mum_character, %{field: new_value})
      {:ok, %MUMCharacter{}}

      iex> update_mum_character(mum_character, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mum_character(%MUMCharacter{} = mum_character, attrs) do
    mum_character
    |> MUMCharacter.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mum_character.

  ## Examples

      iex> delete_mum_character(mum_character)
      {:ok, %MUMCharacter{}}

      iex> delete_mum_character(mum_character)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mum_character(%MUMCharacter{} = mum_character) do
    Repo.delete(mum_character)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mum_character changes.

  ## Examples

      iex> change_mum_character(mum_character)
      %Ecto.Changeset{data: %MUMCharacter{}}

  """
  def change_mum_character(%MUMCharacter{} = mum_character, attrs \\ %{}) do
    MUMCharacter.changeset(mum_character, attrs)
  end
end
