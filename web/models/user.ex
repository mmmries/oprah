defmodule Oprah.User do
  use Oprah.Web, :model

  schema "users" do
    field :avatar_url, :string
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
    |> cast(params, [:name, :github_id, :gitlab_id, :avatar_url])
    |> validate_required([:name])
    |> validate_length(:name, min: 4, max: 20)
    |> unique_constraint(:name)
  end

  def user_from_uberauth_info(gitlab_id, name, avatar_url) do
    case Repo.get_by(User, gitlab_id: gitlab_id) do
      nil -> Repo.insert!(%User{gitlab_id: gitlab_id, name: name, avatar_url: avatar_url})
      user ->
        cast(user, %{gitlab_id: gitlab_id, name: name, avatar_url: avatar_url}, [:gitlab_id, :name, :avatar_url])
        |> Oprah.Repo.update!
      end
  end
end
