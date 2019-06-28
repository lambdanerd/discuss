defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  def join("comments:" <> topic_id, _params, socket) do
    topic =
      Disucss.Topic
      |> Repo.get(String.to_integer(topic_id))

    {:ok, %{}, socket}
  end

  def handle_in(name, message, socket) do
    {:reply, :ok, socket}
  end
end
