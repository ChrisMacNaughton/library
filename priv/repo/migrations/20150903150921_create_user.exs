defmodule Library.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :username, :string
      add :hash, :string
      add :recovery_hash, :string

      timestamps
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])

  end
end
