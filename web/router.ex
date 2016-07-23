defmodule Oprah.Router do
  use Oprah.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Oprah.Auth, repo: Oprah.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Oprah do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", SessionController, :login
    get "/logout", SessionController, :logout
    post "/login", SessionController, :create
    resources "/users", UserController
    resources "/nominations", NominationController
  end

  scope "/auth", Oprah do
    pipe_through :browser

    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :callback
  end
end
