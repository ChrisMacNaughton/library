defmodule Library.User do
  use Library.Web, :model
  @derive [Poison.Encoder]
  defstruct [:first_name, :last_name, :email, :username]

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :username, :string
    field :hash, :string
    field :recovery_hash, :string

    has_many :books, Library.Book
    has_many :authors, Library.Author
    timestamps
  end

  @required_fields ~w(first_name last_name email username hash recovery_hash)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:email, on: Library.Repo, downcase: true)
    |> validate_unique(:username, on: Library.Repo, downcase: true)
  end
end
