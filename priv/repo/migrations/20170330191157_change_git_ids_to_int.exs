defmodule Oprah.Repo.Migrations.ChangeGitIdsToInt do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :gitlab_id
      remove :github_id

      add :gitlab_id, :integer
      add :github_id, :integer
    end
  end
end
