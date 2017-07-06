defmodule Mango.Web.Router do
  use Mango.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Mango.Web.Plugs.LoadCustomer
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mango.Web do
    pipe_through :browser # Use the default browser stack

    get   "/", PageController, :index

    get   "/categories/:name", CategoryController, :index

    get   "/register", RegistrationController, :new
    post  "/register", RegistrationController, :create

    get   "/login",  SessionController, :new
    post  "/login",  SessionController, :create
    get   "/logout", SessionController, :delete
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mango.Web do
  #   pipe_through :api
  # end
end
