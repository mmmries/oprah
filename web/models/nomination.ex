defmodule Oprah.Nomination do
  use Oprah.Web, :model

  schema "nominations" do
    field :body, :string
    field :awarded_at, Ecto.DateTime
    belongs_to :nominee, Oprah.Nominee
    belongs_to :nominated_by, Oprah.NominatedBy

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :awarded_at])
    |> validate_required([:body, :nominee_id, :nominated_by_id])
  end
end
