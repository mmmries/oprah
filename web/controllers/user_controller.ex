defmodule Oprah.UserController do
  use Oprah.Web, :controller
  plug :require_current_user

  def index(conn, _params) do
    {:ok, users} = Image.user_all()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    case Image.get_user(id) do
      {:ok, user} ->
        user = Map.put(user, :nominations_received, []) # TODO: make this lookup the nominations
        render(conn, "show.html", user: user)
      {:error, :not_found} ->
        raise Oprah.NotFound, message: "user not found"
    end
  end
end
