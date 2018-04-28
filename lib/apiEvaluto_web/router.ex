defmodule ApiEvalutoWeb.Router do
  use ApiEvalutoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiEvalutoWeb do
    pipe_through :api
    
    resources "/tenants", TenantController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/groups", GroupController, except: [:new, :edit]
    resources "/credentials", CredentialController, except: [:new, :edit]
    resources "/memberships", MembershipController, except: [:new, :edit]
    
  end
end
