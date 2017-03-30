defmodule Oprah.User do
  use Oprah.Web, :model

  schema "users" do
    field :name, :string
    field :github_id, :integer
    field :gitlab_id, :integer
    has_many :nominations_received, Oprah.Nomination, foreign_key: :nominee_id
    has_many :nominations_given, Oprah.Nomination, foreign_key: :nominated_by_id
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :github_id, :gitlab_id])
    |> validate_required([:name])
    |> validate_length(:name, min: 4, max: 20)
    |> unique_constraint(:name)
  end

  def user_from_uberauth_info(uid, name) do
    case Repo.get(User, uid) do
      nil -> Repo.insert!(%User{id: uid, name: name})
      user ->
        cast(user, %{name: name}, [:name])
        |> Oprah.Repo.update!
      end
  end
end
