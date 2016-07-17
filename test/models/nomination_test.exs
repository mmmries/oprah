defmodule Oprah.NominationTest do
  use Oprah.ModelCase

  alias Oprah.{Nomination, User}

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    user = Repo.insert!(%User{name: "max"})
    changeset = Nomination.changeset(%Nomination{nominated_by_id: user.id, nominee_id: user.id}, %{body: "body", nominee_id: user.id, nominated_by_id: user.id})
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Nomination.changeset(%Nomination{}, @invalid_attrs)
    refute changeset.valid?
  end
end
