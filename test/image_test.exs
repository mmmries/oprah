defmodule Oprah.ImageTest do
  use ExUnit.Case
  alias Oprah.Image

  test "can find a user" do
    {:ok, user} = Image.get_user("dan")
    assert user == %Oprah.User{gitlab_id: 1, id: "dan", name: "dan"}
  end

  test "can find all users" do
    {:ok, users} = Image.user_all()
    ids = users |> Enum.map(&( &1.id )) |> Enum.sort
    assert ids == ["dan", "don", "ron"]
  end
end
