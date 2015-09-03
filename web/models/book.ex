defmodule Library.Book do
  use Library.Web, :model

  schema "books" do
    field :title, :string
    field :description, :string
    field :isbn, :string
    field :upc, :string
    belongs_to :author, Library.Author

    timestamps
  end

  @required_fields ~w(title author_id)
  @optional_fields ~w(description isbn upc)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
