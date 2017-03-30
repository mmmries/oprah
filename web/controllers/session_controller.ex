defmodule Oprah.SessionController do
  use Oprah.Web, :controller
  plug Ueberauth

  def login(conn, _params) do
    redirect(conn, to: "/auth/gitlab")
  end

  def logout(conn, _params) do
    conn |> configure_session(drop: true) |> redirect(to: nomination_path(conn, :pick_a_nominee))
  end

  def callback(%{assigns: %{ueberauth_failure: %{errors: errors}}}=conn, _params) do
    render(conn, :error, errors: errors)
  end
  def callback(%{assigns: %{ueberauth_auth: %{info: %{name: name}, uid: gitlab_id}}}=conn, _params) do
    user = Oprah.User.user_from_uberauth_info(gitlab_id, name)
    conn |> put_session(:user_id, user.id) |> put_flash(:info, "Yo #{user.name}") |> redirect(to: nomination_path(conn, :pick_a_nominee))
  end
end
