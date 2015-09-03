defmodule Library.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :description, :text
      add :isbn, :string
      add :upc, :string
      add :author_id, references(:authors)

      timestamps
    end
    create index(:books, [:author_id])

  end
end
