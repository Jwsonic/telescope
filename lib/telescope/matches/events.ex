defmodule Telescope.Matches.Events do
  alias Phoenix.PubSub
  alias Telescope.Matches.Match

  @topic "#{__MODULE__}"

  def broadcast(%Match{} = match) do
    PubSub.broadcast(Telescope.PubSub, @topic, match)
  end

  def subscribe do
    PubSub.subscribe(Telescope.PubSub, @topic)
  end
end
