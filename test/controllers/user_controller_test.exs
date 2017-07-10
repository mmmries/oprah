defmodule Oprah.UserControllerTest do
  use Oprah.ConnCase

  alias Oprah.User
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  @tag login_as: "dan"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Users"
  end

  @tag login_as: "dan"
  test "shows chosen resource", %{conn: conn} do
    {:ok, user} = Image.get_user("don")
    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "don"
  end

  @tag login_as: "dan"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end
end
