defmodule Telescope.Valve do
  use TypeCheck

  @type! opts :: keyword(binary())

  @default_base_url "https://api.steampowered.com/IDOTA2Match_570"
  @match_history_path "/GetMatchHistoryBySequenceNum/v0001/"

  @matches_requested 200

  @spec! match_history(match_seq_num :: non_neg_integer(), api_key :: binary(), opts :: opts()) ::
           {:ok, list(map())} | {:error, binary()}
  def match_history(match_seq_num, api_key, opts \\ []) do
    @match_history_path
    |> build_url(match_seq_num, api_key, opts)
    |> make_request()
    |> process_response()
  end

  defp build_url(path, match_seq_num, api_key, opts) do
    base_url = Keyword.get(opts, :base_url, @default_base_url)

    query_params =
      URI.encode_query(%{
        key: api_key,
        start_at_match_seq_num: match_seq_num,
        matches_requested: @matches_requested
      })

    "#{base_url}#{path}?#{query_params}"
  end

  defp make_request(url) do
    :get |> Finch.build(url) |> Finch.request(FinchHttp)
  end

  defp process_response({:ok, %Finch.Response{body: body}}) do
    body |> Jason.decode() |> process_response()
  end

  defp process_response({:ok, data}) when is_map(data) do
    response = data |> Map.get("result", %{}) |> Map.get("matches", [])

    {:ok, response}
  end

  defp process_response({:error, %Jason.DecodeError{} = error}) do
    {:error, Jason.DecodeError.message(error)}
  end

  defp process_response({:error, _error}) do
    {:error, "Request failed."}
  end
end
