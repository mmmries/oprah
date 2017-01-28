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

    get "/", NominationController, :pick_a_nominee
    get "/login", SessionController, :login
    get "/logout", SessionController, :logout
    get "/nominations/recent_winners", NominationController, :recent_winners
    get "/nominations/pick_a_winner", NominationController, :pick_a_winner
    get "/nominations/clear_eligible_nominations", NominationController, :clear_eligible_nominations
    resources "/users", UserController
    resources "/nominations", NominationController
  end

  scope "/auth", Oprah do
    pipe_through :browser

    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :callback
  end
end
