defmodule Library.AuthorControllerTest do
  use Library.ConnCase

  alias Library.Author
  @valid_attrs %{first_name: "some content", last_name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, author_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing authors"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, author_path(conn, :new)
    assert html_response(conn, 200) =~ "New author"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, author_path(conn, :create), author: @valid_attrs
    assert redirected_to(conn) == author_path(conn, :index)
    assert Repo.get_by(Author, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, author_path(conn, :create), author: @invalid_attrs
    assert html_response(conn, 200) =~ "New author"
  end

  test "shows chosen resource", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = get conn, author_path(conn, :show, author)
    assert html_response(conn, 200) =~ "Show author"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, author_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = get conn, author_path(conn, :edit, author)
    assert html_response(conn, 200) =~ "Edit author"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = put conn, author_path(conn, :update, author), author: @valid_attrs
    assert redirected_to(conn) == author_path(conn, :show, author)
    assert Repo.get_by(Author, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = put conn, author_path(conn, :update, author), author: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit author"
  end

  test "deletes chosen resource", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = delete conn, author_path(conn, :delete, author)
    assert redirected_to(conn) == author_path(conn, :index)
    refute Repo.get(Author, author.id)
  end
end
