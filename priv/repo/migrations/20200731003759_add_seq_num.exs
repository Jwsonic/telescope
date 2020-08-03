defmodule Telescope.Repo.Migrations.AddSeqNum do
  use Ecto.Migration

  def up do
    create table("seq_num") do
      add(:match_seq_num, :bigint, null: false)

      timestamps()
    end
  end

  def down do
    drop_if_exists(table("seq_num"))
  end
end
