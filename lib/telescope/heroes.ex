defmodule Telescope.Heroes do
  use Agent

  require Logger

  def start_link(_args) do
    Agent.start_link(&fetch_heroes/0, name: __MODULE__)
  end

  @spec get_name(id :: non_neg_integer()) :: String.t()
  def get_name(id) do
    __MODULE__
    |> Agent.get(& &1)
    |> Map.get(id, %{})
    |> Map.get("localized_name", "Unknown")
  end

  defp fetch_heroes do
    with {:ok, {{_http_version, 200, _reason}, _headers, body}} <-
           :httpc.request('https://api.opendota.com/api/heroes'),
         body <- to_string(body),
         {:ok, heroes} <- Jason.decode(body) do
      Logger.info("Got #{length(heroes)} heroes.")

      Enum.reduce(heroes, %{}, fn hero, acc ->
        key = Map.get(hero, "id", "no_id")

        Map.put(acc, key, hero)
      end)
    else
      _ -> %{}
    end
  end
end
