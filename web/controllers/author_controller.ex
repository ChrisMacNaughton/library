defmodule Library.AuthorController do
  use Library.Web, :controller

  alias Library.Author

  plug :scrub_params, "author" when action in [:create, :update]
  plug Addict.Plugs.Authenticated

  def index(conn, _params) do
    user = Library.Session.current_user(conn)
    import Ecto.Query, only: [from: 2]
    query = from author in Library.Author,
      where: author.user_id == ^user.id,
      select: author
    authors = Repo.all(query)
    render(conn, "index.html", authors: authors)
  end

  def new(conn, _params) do
    changeset = Author.changeset(%Author{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    user = Library.Session.current_user(conn)
    changeset = Author.changeset(%Author{user_id: user.id}, author_params)

    case Repo.insert(changeset) do
      {:ok, _author} ->
        conn
        |> put_flash(:info, "Author created successfully.")
        |> redirect(to: author_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Repo.get!(Author, id)
    books = assoc(author, :books) |> Repo.all
    render(conn, "show.html", author: author, books: books)
  end

  def edit(conn, %{"id" => id}) do
    author = Repo.get!(Author, id)
    changeset = Author.changeset(author)
    render(conn, "edit.html", author: author, changeset: changeset)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Repo.get!(Author, id)
    changeset = Author.changeset(author, author_params)

    case Repo.update(changeset) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author updated successfully.")
        |> redirect(to: author_path(conn, :show, author))
      {:error, changeset} ->
        render(conn, "edit.html", author: author, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Repo.get!(Author, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(author)

    conn
    |> put_flash(:info, "Author deleted successfully.")
    |> redirect(to: author_path(conn, :index))
  end
end
