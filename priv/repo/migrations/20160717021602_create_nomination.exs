defmodule Oprah.Repo.Migrations.CreateNomination do
  use Ecto.Migration

  def change do
    create table(:nominations) do
      add :body, :string
      add :awarded_at, :datetime
      add :nominee_id, references(:users, on_delete: :nothing)
      add :nominated_by_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:nominations, [:nominee_id])
    create index(:nominations, [:nominated_by_id])

  end
end
