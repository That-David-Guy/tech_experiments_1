defmodule TechExperiments1.LVTE do
  @moduledoc """
  The LVTE context.
  """

  import Ecto.Query, warn: false
  alias TechExperiments1.Repo

  alias TechExperiments1.LVTE.LVTEBall

  @doc """
  Returns the list of lvte_balls.

  ## Examples

      iex> list_lvte_balls()
      [%LVTEBall{}, ...]

  """
  def list_lvte_balls do
    Repo.all(LVTEBall)
  end

  @doc """
  Gets a single lvte_ball.

  Raises `Ecto.NoResultsError` if the Lvte ball does not exist.

  ## Examples

      iex> get_lvte_ball!(123)
      %LVTEBall{}

      iex> get_lvte_ball!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lvte_ball!(id), do: Repo.get!(LVTEBall, id)

  @doc """
  Creates a lvte_ball.

  ## Examples

      iex> create_lvte_ball(%{field: value})
      {:ok, %LVTEBall{}}

      iex> create_lvte_ball(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lvte_ball(attrs \\ %{}) do
    %LVTEBall{}
    |> LVTEBall.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lvte_ball.

  ## Examples

      iex> update_lvte_ball(lvte_ball, %{field: new_value})
      {:ok, %LVTEBall{}}

      iex> update_lvte_ball(lvte_ball, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lvte_ball(%LVTEBall{} = lvte_ball, attrs) do
    lvte_ball
    |> LVTEBall.changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Deletes a lvte_ball.

  ## Examples

      iex> delete_lvte_ball(lvte_ball)
      {:ok, %LVTEBall{}}

      iex> delete_lvte_ball(lvte_ball)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lvte_ball(%LVTEBall{} = lvte_ball) do
    Repo.delete(lvte_ball)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lvte_ball changes.

  ## Examples

      iex> change_lvte_ball(lvte_ball)
      %Ecto.Changeset{data: %LVTEBall{}}

  """
  def change_lvte_ball(%LVTEBall{} = lvte_ball, attrs \\ %{}) do
    LVTEBall.changeset(lvte_ball, attrs)
  end


  def to_list_of_maps(structs) do
    Enum.map(structs, fn struct ->
      Map.take(struct, [:id, :color, :size])
    end)
  end
end
