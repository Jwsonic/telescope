defmodule Telscope.Valve do
  @type opts :: [base_url :: String.t()]

  @definitions [
    base_url: [
      type: :string
    ],
    api_key: [
      type: :string,
      required: true
    ]
  ]

  @spec match_history(match_seq_num :: non_neg_integer(), opts :: opts()) ::
          {:ok, list(map())} | {:error, String.t()}
  def match_history(_match_seq_num, opts \\ []) do
    "GetMatchHistoryBySequenceNum/v0001/"
    |> build_url(opts)
    |> make_request()
    |> process_response()
  end

  defp build_url(path, opts) do
    opts
    |> Keyword.get(:base_url, "https://api.steampowered.com/IDOTA2Match_570/")
    |> Kernel.<>(path)
  end

  defp make_request(url) do
    :get |> Finch.build(url) |> Finch.request(FinchHttp)
  end

  defp process_response({:ok, %Finch.Response{body: body}}) do
    body |> Jason.decode() |> process_response()
  end

  defp process_response({:ok, data}) when is_map(data) do
    {:ok, data}
  end

  defp process_response({:error, %Jason.DecodeError{} = error}) do
    {:error, Jason.DecodeError.message(error)}
  end

  defp process_response({:error, _error}) do
    {:error, "Request failed."}
  end
end
