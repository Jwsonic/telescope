defmodule Telescope.Valve.Impl do
  @moduledoc """
  Impl is the logic implementation for `Telescope.Valve.MatchFetchServer`.
  """
  alias Telescope.Matches
  alias Telescope.Valve.ApiClient

  require Logger

  @spec init() :: :ok
  def init do
    schedule_fetch()

    :ok
  end

  @spec fetch() :: :ok
  def fetch do
    match_seq_num = Matches.get_match_seq_num()

    Logger.info("Fetching matches with seq num: #{match_seq_num}.")

    match_seq_num
    |> ApiClient.match_history()
    |> handle_match_result()

    schedule_fetch()
  end

  defp handle_match_result({:ok, matches}) do
    Matches.process(matches)
  end

  defp handle_match_result({:error, error}) do
    Logger.error(error)
  end

  @interval 2_000

  defp schedule_fetch do
    Process.send_after(self(), :fetch, @interval)

    :ok
  end
end
