defmodule Library.BookController do
  use Library.Web, :controller

  alias Library.Book

  plug :scrub_params, "book" when action in [:create, :update]
  plug Addict.Plugs.Authenticated
  plug :current_user

  def index(conn, _params) do
    user = conn.assigns.user
    query = from book in Library.Book,
      where: book.user_id == ^user.id,
      select: book
    books = assoc(user, :books) |>Repo.all |> Repo.preload [:author]
    # books = Book |> Repo.all |> Repo.preload [:author]
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = Book.changeset(%Book{})
    authors = Repo.all(Library.Author)
    render(conn, "new.html", changeset: changeset, authors: authors)
  end

  def create(conn, %{"book" => book_params}) do
    user = conn.assigns.user
    changeset = Book.changeset(%Book{user_id: user.id}, book_params)
    case Repo.insert(changeset) do
      {:ok, _book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: book_path(conn, :index))
      {:error, changeset} ->
        authors = Repo.all(Library.Author)
        render(conn, "new.html", changeset: changeset, authors: authors)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Book |> Repo.get(id) |> Repo.preload [:author]
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book)
    authors = Repo.all(Library.Author)
    render(conn, "edit.html", book: book, changeset: changeset, authors: authors)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book, book_params)

    case Repo.update(changeset) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: book_path(conn, :show, book))
      {:error, changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: book_path(conn, :index))
  end

  def current_user(conn, _) do
    user = Library.Session.current_user(conn)
    assign(conn, :user, user)
  end
end
