defmodule TechExperiments1.Repo.Migrations.CreateMumCharacters do
  use Ecto.Migration

  def change do
    create table(:mum_characters) do
      add :position_x, :integer
      add :position_y, :integer
      add :graphic, :string

      timestamps()
    end

  end
end
