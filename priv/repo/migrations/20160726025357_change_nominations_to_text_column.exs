defmodule Oprah.Repo.Migrations.ChangeNominationsToTextColumn do
  use Ecto.Migration

  def change do
    alter table(:nominations) do
      modify(:body, :text)
    end
  end
end
