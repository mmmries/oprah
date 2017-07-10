defmodule Oprah.Auth do
  use Phoenix.Controller

  def init(_opts), do: nil

  def call(%{assigns: %{current_user: _user}}=conn, _opts), do: conn
  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil -> conn
      user_id ->
        {:ok, user} = Oprah.Image.get_user(user_id)
        assign(conn, :current_user, user)
    end
  end

  def require_current_user(%{assigns: %{current_user: _user}}=conn, _opts) do
    conn
  end
  def require_current_user(conn, _opts) do
    conn |> redirect(to: "/login") |> halt
  end
end
