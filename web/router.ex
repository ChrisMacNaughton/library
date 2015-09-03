defmodule Library.Router do
  use Addict.RoutesHelper
  use Library.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Library do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", PageController, :login
    get "/register", PageController, :register
    resources "/authors", AuthorController
    resources "/books", BookController
    resources "/users", UserController, only: [:show, :edit, :update, :delete]
  end

  scope "/" do
    addict :routes
  end

  # Other scopes may use custom stacks.
  # scope "/api", Library do
  #   pipe_through :api
  # end
end
