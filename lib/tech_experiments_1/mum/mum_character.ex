defmodule TechExperiments1.MUM.MUMCharacter do
  @moduledoc """
  A character that can be moved around a map
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "mum_characters" do
    field :graphic, :string
    field :position_x, :integer
    field :position_y, :integer

    timestamps()
  end

  @doc false
  def changeset(mum_character, attrs) do
    mum_character
    |> cast(attrs, [:position_x, :position_y, :graphic])
    |> validate_required([:position_x, :position_y, :graphic])
  end
end
