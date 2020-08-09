defmodule Telescope.Repo.Migrations.AddMatchPlayer do
  use Ecto.Migration

  def up do
    create table("match_players") do
      add(:hero, :string, null: false)
      add(:name, :string, null: false)
      add(:radiant?, :boolean, default: true, null: false)

      add(:match_id, references("matches", on_delete: :delete_all))

      timestamps()
    end

    create(unique_index("match_players", [:hero, :name], name: :player_hero))
    create(unique_index("match_players", [:name, :match_id]))
  end

  def down do
    drop_if_exists(table("match_players"))
  end
end
