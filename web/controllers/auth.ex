defmodule Oprah.Auth do
  use Phoenix.Controller

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case get_session(conn, :user_id) do
      nil -> conn
      user_id ->
        assign(conn, :current_user, repo.get(Oprah.User, user_id))
    end
  end

  def require_current_user(%{assigns: %{current_user: _user}}=conn, _opts) do
    conn
  end
  def require_current_user(conn, _opts) do
    conn |> redirect(to: "/login") |> halt
  end
end
