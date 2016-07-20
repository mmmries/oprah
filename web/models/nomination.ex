defmodule Oprah.Nomination do
  use Oprah.Web, :model

  schema "nominations" do
    field :body, :string
    field :awarded_at, Ecto.DateTime
    belongs_to :nominee, Oprah.User
    belongs_to :nominated_by, Oprah.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :awarded_at, :nominee_id, :nominated_by_id])
    |> validate_required([:body, :nominee_id, :nominated_by_id])
    |> do_not_nominate_yourself
  end

  defp do_not_nominate_yourself(changeset) do
    if fetch_field(changeset, :nominee_id) == fetch_field(changeset, :nominated_by_id) do
      add_error(changeset, :nominee_id, "You can't nominate yourself")
    else
      changeset
    end
  end
end
