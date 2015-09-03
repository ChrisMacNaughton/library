defmodule Library.Repo.Migrations.AddUserToBooksAndAuthors do
  use Ecto.Migration

  def change do
    alter table(:authors) do
      add :user_id, references(:users)
    end

    alter table(:books) do
      add :user_id, references(:users)
    end
  end
end
