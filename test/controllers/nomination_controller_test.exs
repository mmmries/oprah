defmodule Oprah.NominationControllerTest do
  use Oprah.ConnCase

  alias Oprah.Nomination

  @tag login_as: "dan"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, nomination_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing nominations"
  end

  @tag login_as: "dan"
  test "renders form for new resources", %{conn: conn, user: user} do
    conn = get conn, nomination_path(conn, :new, %{nomination: %{nominee_id: user.id}})
    assert html_response(conn, 200) =~ "New nomination"
  end

  @tag login_as: "dan"
  test "creates resource and redirects when data is valid", %{conn: conn, user: user} do
    conn = post conn, nomination_path(conn, :create), nomination: valid_attrs(user)
    assert redirected_to(conn) == nomination_path(conn, :index)
    assert Repo.get_by(Nomination, nominee_id: user.id)
  end

  @tag login_as: "dan"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, nomination_path(conn, :create), nomination: %{nominee_id: "-1"}
    assert html_response(conn, 200) =~ "New nomination"
  end

  @tag login_as: "dan"
  test "shows chosen resource", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = get conn, nomination_path(conn, :show, nomination)
    assert html_response(conn, 200) =~ "Show nomination"
  end

  @tag login_as: "dan"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, nomination_path(conn, :show, -1)
    end
  end

  @tag login_as: "dan"
  test "renders form for editing chosen resource", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = get conn, nomination_path(conn, :edit, nomination)
    assert html_response(conn, 200) =~ "Edit nomination"
  end

  @tag login_as: "dan"
  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    nomination = Repo.insert! %Nomination{nominated_by_id: user.id, nominee_id: user.id}
    conn = put conn, nomination_path(conn, :update, nomination), nomination: valid_attrs(user)
    assert redirected_to(conn) == nomination_path(conn, :show, nomination)
    assert Repo.get_by(Nomination, nominee_id: user.id)
  end

  @tag login_as: "dan"
  @tag skip: true
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = put conn, nomination_path(conn, :update, nomination), nomination: %{nominee_id: "-1"}
    assert html_response(conn, 200) =~ "Edit nomination"
  end

  @tag login_as: "dan"
  test "deletes chosen resource", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = delete conn, nomination_path(conn, :delete, nomination)
    assert redirected_to(conn) == nomination_path(conn, :index)
    refute Repo.get(Nomination, nomination.id)
  end

  def valid_attrs(user) do
    %{
      body: "Just Cuz",
      nominee_id: to_string(user.id),
    }
  end
end
