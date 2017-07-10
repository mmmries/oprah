defmodule Oprah.NominationController do
  use Oprah.Web, :controller
  alias Oprah.Image
  plug :require_current_user when action != :pick_a_nominee

  def clear_eligible_nominations(conn, _params) do
   #query = from n in Nomination,
   #        where: [eligible_to_win: true]
   #Repo.update_all(query, set: [eligible_to_win: false])
   #redirect(conn, to: nomination_path(conn, :recent_winners))
  end

  def index(conn, _params) do
   #query = from n in Nomination,
   #        where: [eligible_to_win: true],
   #        preload: [:nominee, :nominated_by],
   #        order_by: [desc: n.inserted_at]
   #nominations = Repo.all(query)
   #render(conn, "index.html", nominations: nominations)
  end

  def pick_a_nominee(conn, _params) do
   users = [] # TODO: get this from the image
   render(conn, "pick_a_nominee.html", users: users)
  end

  def pick_a_winner(conn, _params) do
   #nomination_counts = nomination_counts_by_nominee_id()
   #max_count = Enum.map(nomination_counts, &(List.last(&1)) ) |> Enum.max
   #top_candidates = Enum.filter(nomination_counts, &(List.last(&1) == max_count))
   #                 |> Enum.map(&( hd(&1) ))
   #:rand.seed(:exsplus, :erlang.now())
   #nominee_id = Enum.random(top_candidates)
   #mark_unawared_nominations_as_awarded_for_user(nominee_id)
   #redirect(conn, to: nomination_path(conn, :recent_winners))
  end

  def recent_winners(conn, _params) do
   #q = from n in Nomination,
   #    where: not is_nil(n.awarded_at),
   #    order_by: [desc: n.awarded_at],
   #    preload: [:nominee, :nominated_by]
   #grouped_nominations = Repo.all(q)
   #                      |> Enum.group_by(&( &1.awarded_at ))
   #nomination_counts = nomination_counts_by_nominee_id()
   #number_nominees = Enum.count(nomination_counts)
   #number_nominations = Enum.reduce(nomination_counts, 0, &( &2 + List.last(&1)))

   #render conn, "recent_winners.html", grouped_nominations: grouped_nominations,
   #                                    number_nominees: number_nominees,
   #                                    number_nominations: number_nominations
  end

  def new(conn, %{"nomination" => params}) do
   #changeset = Nomination.changeset(%Nomination{}, params)
   #render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"nomination" => nomination_params}) do
   #nomination_params = Map.put(nomination_params, "nominated_by_id", conn.assigns.current_user.id)
   #changeset = Nomination.changeset(%Nomination{eligible_to_win: true}, nomination_params)

   #case Repo.insert(changeset) do
   #  {:ok, _nomination} ->
   #    conn
   #    |> put_flash(:info, "Nomination created successfully.")
   #    |> redirect(to: nomination_path(conn, :index))
   #  {:error, changeset} ->
   #    render(conn, "new.html", changeset: changeset)
   #end
  end

  def show(conn, %{"id" => id}) do
   #query = from n in Nomination,
   #        where: [id: ^id],
   #        preload: [:nominee, :nominated_by]
   #nomination = Repo.one!(query)
   #render(conn, "_nomination.html", nomination: nomination)
  end

  def edit(conn, %{"id" => id}) do
   #nomination = Repo.get!(Nomination, id)
   #changeset = Nomination.changeset(nomination)
   #render(conn, "edit.html", nomination: nomination, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nomination" => nomination_params}) do
   #nomination = Repo.get!(Nomination, id)
   #changeset = Nomination.changeset(nomination, nomination_params)

   #case Repo.update(changeset) do
   #  {:ok, nomination} ->
   #    conn
   #    |> put_flash(:info, "Nomination updated successfully.")
   #    |> redirect(to: nomination_path(conn, :show, nomination))
   #  {:error, changeset} ->
   #    render(conn, "edit.html", nomination: nomination, changeset: changeset)
   #end
  end

  def delete(conn, %{"id" => id}) do
   #nomination = Repo.get!(Nomination, id)

   ## Here we use delete! (with a bang) because we expect
   ## it to always work (and if it does not, it will raise).
   #Repo.delete!(nomination)

   #conn
   #|> put_flash(:info, "Nomination deleted successfully.")
   #|> redirect(to: nomination_path(conn, :index))
  end

  defp mark_unawared_nominations_as_awarded_for_user(user_id) do
   #awarded_at = Ecto.DateTime.from_erl(:calendar.local_time())
   #q = from n in Nomination,
   #  where: n.nominee_id == ^user_id and is_nil(n.awarded_at) and n.eligible_to_win == true
   #Enum.each(Repo.all(q), &(
   #  Nomination.changeset(&1, %{awarded_at: awarded_at, eligible_to_win: false})
   #  |> Repo.update!
   #))
  end

  defp nomination_counts_by_nominee_id do
   #q = from n in Nomination,
   #    where: [eligible_to_win: true],
   #    select: [n.nominee_id, count(n.id)],
   #    group_by: n.nominee_id
   #Repo.all(q)
  end
end
