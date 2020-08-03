defmodule Telescope.Repo.Migrations.AddMatch do
  use Ecto.Migration

  def up do
    create table("matches") do
      add(:duration, :integer, null: false)
      add(:match_id, :bigint, null: false)
      add(:match_seq_num, :bigint, null: false)
      add(:radiant_win, :boolean, null: false)
      add(:start_time, :utc_datetime, null: false)

      timestamps()
    end

    create(index("matches", [:match_id], unique: true, comment: "Unique index for match id"))

    create(
      index("matches", [:match_seq_num], unique: true, comment: "Unique index for match seq num")
    )
  end

  def down do
    drop_if_exists(table("matches"))
  end
end
