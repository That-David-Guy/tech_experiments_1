defmodule TechExperiments1.MUM.MUMCharacter do
  @moduledoc """
  For the Multi User Map tech experiment
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "mum_characters" do
    field :graphic, :string
    field :position_x, :integer, default: 0
    field :position_y, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(mum_character, attrs) do
    mum_character
    |> cast(attrs, [:position_x, :position_y, :graphic])
    |> validate_required([:position_x, :position_y, :graphic])
  end
end
