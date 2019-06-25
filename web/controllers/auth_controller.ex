defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)

  def callback(conn, params) do
    IO.puts(conn.assigns)
    IO.puts(params)
  end
end
