defmodule Library.Author do
  use Library.Web, :model

  schema "authors" do
    field :first_name, :string
    field :last_name, :string

    has_many :books, Library.Book
    belongs_to :user, Library.User
    timestamps
  end

  @required_fields ~w(first_name last_name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  # def last_name do
  #   first_name + last_name
  # end
end
