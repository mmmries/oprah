defmodule Oprah.User do
  use Oprah.Web, :model

  schema "users" do
    field :name, :string
    has_many :nominations_received, Oprah.Nomination, foreign_key: :nominee_id
    has_many :nominations_given, Oprah.Nomination, foreign_key: :nominated_by_id
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 4, max: 20)
    |> unique_constraint(:name)
  end
end
