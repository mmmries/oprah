defmodule Oprah.Repo.Migrations.AddEligibleToWinToNominations do
  use Ecto.Migration

  def change do
    alter table(:nominations) do
      add :eligible_to_win, :boolean
    end
  end
end
