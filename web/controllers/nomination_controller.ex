defmodule Oprah.NominationController do
  use Oprah.Web, :controller
  alias Oprah.Nomination
  plug :require_current_user when action != :index

  def index(conn, _params) do
    query = from n in Nomination,
            where: is_nil(n.awarded_at),
            preload: [:nominee, :nominated_by],
            order_by: [desc: n.inserted_at]
    nominations = Repo.all(query)
    render(conn, "index.html", nominations: nominations)
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
    nomination = Repo.get!(Nomination, id)
    render(conn, "show.html", nomination: nomination)
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
