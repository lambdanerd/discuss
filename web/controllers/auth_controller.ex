defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user = %{
      email: auth.info.email,
      provider: "#{auth.provider}",
      token: auth.credentials.token
    }

    changeset = Discuss.User.changeset(%Discuss.User{}, user)

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in.")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(Discuss.User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
