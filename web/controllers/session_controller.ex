defmodule Oprah.SessionController do
  use Oprah.Web, :controller

  def create(conn, %{"session" => %{"name" => name}}) do
    case Repo.get_by(Oprah.User, name: name) do
      nil ->
        conn |> put_flash(:error, "Invalid username") |> render(:login)
      %Oprah.User{id: user_id, name: user_name} ->
        conn |> put_session(:user_id, user_id) |> put_flash(:info, "Yo #{user_name}") |> redirect(to: user_path(conn, :index))
    end
  end

  def login(conn, _params) do
    render(conn, :login)
  end

  def logout(conn, _params) do
    conn |> configure_session(drop: true) |> redirect(to: session_path(conn, :login))
  end
end
