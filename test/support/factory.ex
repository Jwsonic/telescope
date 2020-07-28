defmodule Telescope.Factory do
  use ExMachina.Ecto, repo: Telescope.Repo

  alias Telescope.Games.Game

  def game_factory do
    %Game{
      duration: 6_000,
      match_id: sequence(:match_id, & &1),
      match_seq_num: sequence(:match_seq_num, & &1),
      radiant_win: false,
      start_time: DateTime.utc_now() |> DateTime.truncate(:second)
    }
  end
end