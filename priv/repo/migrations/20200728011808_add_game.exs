defmodule Telescope.Repo.Migrations.AddGame do
  use Ecto.Migration

  def up do
    create table("games") do
      add(:duration, :integer, null: false)
      add(:match_id, :integer, null: false)
      add(:match_seq_num, :integer, null: false)
      add(:radiant_win, :boolean, null: false)
      add(:start_time, :utc_datetime, null: false)

      timestamps()
    end

    create(index("games", [:match_id], unique: true, comment: "Unique index for match id"))

    create(
      index("games", [:match_seq_num], unique: true, comment: "Unique index for match seq num")
    )
  end

  def down do
    drop_if_exists(table("games"))
  end
end
