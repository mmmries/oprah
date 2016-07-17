defmodule Oprah.NominationTest do
  use Oprah.ModelCase

  alias Oprah.Nomination

  @valid_attrs %{awarded_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, body: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Nomination.changeset(%Nomination{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Nomination.changeset(%Nomination{}, @invalid_attrs)
    refute changeset.valid?
  end
end
