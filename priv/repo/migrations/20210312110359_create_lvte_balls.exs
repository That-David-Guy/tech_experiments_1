defmodule TechExperiments1.Repo.Migrations.CreateLvteBalls do
  use Ecto.Migration

  def change do
    create table(:lvte_balls) do
      add :color, :string, null: false
      add :size, :string, null: false

      timestamps()
    end

  end
end
