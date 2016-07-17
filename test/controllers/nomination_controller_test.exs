defmodule Oprah.NominationControllerTest do
  use Oprah.ConnCase

  alias Oprah.Nomination
  @valid_attrs %{awarded_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, body: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, nomination_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing nominations"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, nomination_path(conn, :new)
    assert html_response(conn, 200) =~ "New nomination"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, nomination_path(conn, :create), nomination: @valid_attrs
    assert redirected_to(conn) == nomination_path(conn, :index)
    assert Repo.get_by(Nomination, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, nomination_path(conn, :create), nomination: @invalid_attrs
    assert html_response(conn, 200) =~ "New nomination"
  end

  test "shows chosen resource", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = get conn, nomination_path(conn, :show, nomination)
    assert html_response(conn, 200) =~ "Show nomination"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, nomination_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = get conn, nomination_path(conn, :edit, nomination)
    assert html_response(conn, 200) =~ "Edit nomination"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = put conn, nomination_path(conn, :update, nomination), nomination: @valid_attrs
    assert redirected_to(conn) == nomination_path(conn, :show, nomination)
    assert Repo.get_by(Nomination, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = put conn, nomination_path(conn, :update, nomination), nomination: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit nomination"
  end

  test "deletes chosen resource", %{conn: conn} do
    nomination = Repo.insert! %Nomination{}
    conn = delete conn, nomination_path(conn, :delete, nomination)
    assert redirected_to(conn) == nomination_path(conn, :index)
    refute Repo.get(Nomination, nomination.id)
  end
end
