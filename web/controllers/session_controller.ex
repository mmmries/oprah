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
  def callback(%{assigns: %{ueberauth_auth: %{info: %{name: name, urls: urls}, uid: gitlab_id}}}=conn, _params) do
    generated_id = :crypto.strong_rand_bytes(16) |> Base.url_encode64
    avatar_url = Map.get(urls, :avatar_url)
    user = %User{avatar_url: avatar_url, gitlab_id: gitlab_id, id: generated_id, name: name}
    {:ok, user} = Image.user_upsert_by_gitlab_id(user)
    conn |> put_session(:user_id, user.id) |> put_flash(:info, "Yo #{user.name}") |> redirect(to: nomination_path(conn, :pick_a_nominee))
  end
end
