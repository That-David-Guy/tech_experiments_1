defmodule TechExperiments1.MUM do
  @moduledoc """
  The MUM context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias TechExperiments1.Repo

  alias TechExperiments1.MUM.MUMCharacter

  @doc """
  Returns the list of mum_characters.

  ## Examples

      iex> list_mum_characters()
      [%MUMCharacter{}, ...]

  """
  def list_mum_characters do
    Repo.all(from c in MUMCharacter, order_by: [desc: c.id])
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
    |> broadcast(:mum_character_created)
  end

  def quick_create do
    # MAKE SURE THIS IS ATOMIC TO AVOID RACE CONDITIONS
    # Is this atomic?
    new_character = fn(x) ->
      # This should probably be some type of changeset
      i = rem(x, 6) + 1 # Only 6 portraits
      %{
        graphic: "portrait_#{i}.jpg",
        position_x: :rand.uniform(600),
        position_y: :rand.uniform(600)
      }
    end

    Repo.one(from c in MUMCharacter, select: count(c.id))
      |> (new_character).()
      |> create_mum_character
  end

  def quick_delete do
    # MAKE SURE THIS IS ATOMIC TO AVOID RACE CONDITIONS
    last_character = Repo.one(from c in MUMCharacter, order_by: [desc: c.id], limit: 1)
    if last_character != nil do
      delete_mum_character(last_character)
    end
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
    |> broadcast(:mum_character_updated)
  end

  def telelport(%MUMCharacter{} = character) do
    attrs = %{
        position_x: :rand.uniform(600),
        position_y: :rand.uniform(600)
      }
    update_mum_character(character, attrs)
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
    mum_character
    |> Repo.delete
    |> broadcast(:mum_character_deleted)
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

  def subscribe do
    Phoenix.PubSub.subscribe(TechExperiments1.PubSub, "characters")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, character}, event) do
    Phoenix.PubSub.broadcast(TechExperiments1.PubSub, "characters", {event, character})
    {:ok, character}
  end

end
