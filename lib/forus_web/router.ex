defmodule ForusWeb.Router do
  use ForusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ForusWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  scope "/accounts", ForusWeb.Accounts, as: :accounts do
    pipe_through :browser
    
    resources "/users", UserController
  end

end
