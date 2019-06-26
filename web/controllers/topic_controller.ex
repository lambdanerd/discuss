defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  plug(Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete])

  def index(conn, _params) do
    topics =
      Repo.all(Discuss.Topic)
      |> Enum.sort()

    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Discuss.Topic.changeset(%Discuss.Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> Discuss.Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    changeset =
      Repo.get(Discuss.Topic, topic_id)
      |> Discuss.Topic.changeset()

    render(conn, "edit.html", changeset: changeset, topic_id: topic_id)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Discuss.Topic, topic_id)
    changeset = Discuss.Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> render("edit.html", changeset: changeset, topic_id: topic_id)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Discuss.Topic, topic_id) |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end
end
