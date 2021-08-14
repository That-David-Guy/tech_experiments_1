defmodule TechExperiments1.LVTE.LVTEBall do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lvte_balls" do
    field :color, :string, default: "red"
    field :size, :string, default: "medium"

    timestamps()
  end

  @doc false
  def changeset(lvte_ball, attrs) do
    lvte_ball
    |> cast(attrs, [:color, :size])
    |> validate_required([:color, :size])
  end
end
