defmodule Library.BookTest do
  use Library.ModelCase

  alias Library.Book

  @valid_attrs %{description: "some content", isbn: "some content", title: "some content", upc: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
