defmodule Library.Repo.Migrations.CreateAuthor do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :first_name, :string
      add :last_name, :string

      timestamps
    end

  end
end
