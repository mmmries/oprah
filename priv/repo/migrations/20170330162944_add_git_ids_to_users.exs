defmodule Oprah.Repo.Migrations.AddGitIdsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :github_id, :string
      add :gitlab_id, :string
    end
  end
end
