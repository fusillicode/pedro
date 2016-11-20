defmodule Pedro.Router do
  use Pedro.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :auth do
    plug Guardian.Plug.EnsureAuthenticated, handler: Pedro.SessionController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Pedro do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/", SessionController, :new

    scope "/dashboard" do
      pipe_through [:browser_session, :auth]

      get "/", DashboardController, :index
    end
  end
end
