defmodule Telescope.Valve.ApiClient do
  @moduledoc """
  ApiClient is a module abstracting away api requests to valve APIs.
  """

  alias Telescope.Config

  @match_history_path "GetMatchHistoryBySequenceNum/v0001/"

  @matches_requested 200

  @spec match_history(match_seq_num :: non_neg_integer()) ::
          {:ok, list(map())} | {:error, String.t()}
  def match_history(match_seq_num) do
    @match_history_path
    |> build_url(match_seq_num)
    |> make_request()
    |> process_response()
  end

  defp build_url(path, match_seq_num) do
    query_params =
      URI.encode_query(%{
        key: api_key(),
        start_at_match_seq_num: match_seq_num,
        matches_requested: @matches_requested
      })

    "#{base_url()}#{path}?#{query_params}"
  end

  defp base_url, do: Config.valve_base_url!()

  defp api_key, do: Config.valve_api_key!()

  def make_request(url) do
    :get |> Finch.build(url) |> Finch.request(FinchHttp)
  end

  defp process_response({:ok, %Finch.Response{body: body, status: 200}}) do
    body |> Jason.decode() |> handle_decode()
  end

  defp process_response({:ok, %Finch.Response{status: status}}) do
    {:error, "Non OK status code: #{status}"}
  end

  defp process_response({:error, %Mint.TransportError{} = error}) do
    {:error, Mint.TransportError.message(error)}
  end

  defp process_response({:error, %Mint.HTTPError{} = error}) do
    {:error, Mint.HTTPError.message(error)}
  end

  def handle_decode({:ok, data}) when is_map(data) do
    response = data |> Map.get("result", %{}) |> Map.get("matches", [])

    {:ok, response}
  end

  def handle_decode({:ok, data}) do
    {:error, "Decoded result was not a map: #{inspect(data)}"}
  end

  def handle_decode({:error, %Jason.DecodeError{} = error}) do
    {:error, Jason.DecodeError.message(error)}
  end
end
