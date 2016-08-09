defmodule Oprah.NominationController do
  use Oprah.Web, :controller
  alias Oprah.Nomination
  plug :require_current_user when action != :pick_a_nominee

  def index(conn, _params) do
    query = from n in Nomination,
            where: is_nil(n.awarded_at),
            preload: [:nominee, :nominated_by],
            order_by: [desc: n.inserted_at]
    nominations = Repo.all(query)
    render(conn, "index.html", nominations: nominations)
  end

  def pick_a_nominee(conn, _params) do
    query = from u in Oprah.User,
            order_by: [asc: u.name]
    users = Repo.all(query)
    render(conn, "pick_a_nominee.html", users: users)
  end

  def recent_winners(conn, _params) do
    q = from n in Nomination,
        where: not is_nil(n.awarded_at),
        preload: [:nominee, :nominated_by],
        order_by: [desc: n.awarded_at]
    grouped_nominations = Repo.all(q)
    |> Enum.group_by(&( &1.awarded_at ))
    render(conn, "recent_winners.html", grouped_nominations: grouped_nominations)
  end

  def new(conn, %{"nomination" => params}) do
    changeset = Nomination.changeset(%Nomination{}, params)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"nomination" => nomination_params}) do
    nomination_params = Map.put(nomination_params, "nominated_by_id", conn.assigns.current_user.id)
    changeset = Nomination.changeset(%Nomination{}, nomination_params)

    case Repo.insert(changeset) do
      {:ok, _nomination} ->
        conn
        |> put_flash(:info, "Nomination created successfully.")
        |> redirect(to: nomination_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    query = from n in Nomination,
            where: [id: ^id],
            preload: [:nominee, :nominated_by]
    nomination = Repo.one!(query)
    render(conn, "_nomination.html", nomination: nomination)
  end

  def edit(conn, %{"id" => id}) do
    nomination = Repo.get!(Nomination, id)
    changeset = Nomination.changeset(nomination)
    render(conn, "edit.html", nomination: nomination, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nomination" => nomination_params}) do
    nomination = Repo.get!(Nomination, id)
    changeset = Nomination.changeset(nomination, nomination_params)

    case Repo.update(changeset) do
      {:ok, nomination} ->
        conn
        |> put_flash(:info, "Nomination updated successfully.")
        |> redirect(to: nomination_path(conn, :show, nomination))
      {:error, changeset} ->
        render(conn, "edit.html", nomination: nomination, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    nomination = Repo.get!(Nomination, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(nomination)

    conn
    |> put_flash(:info, "Nomination deleted successfully.")
    |> redirect(to: nomination_path(conn, :index))
  end
end
