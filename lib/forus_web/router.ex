defmodule ForusWeb.Router do
  use ForusWeb, :router
  
  import ForusWeb.Auth, only: [assign_current_user: 2]
  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  scope "/", ForusWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  scope "/accounts", ForusWeb.Accounts, as: :accounts do
    pipe_through :browser
    
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
      singleton: true
  end

end
