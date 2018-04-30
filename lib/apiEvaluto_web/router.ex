defmodule ApiEvalutoWeb.Router do
  use ApiEvalutoWeb, :router
  alias ApiEvaluto.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated_admin do
    plug Guardian.AuthPipeline
    plug ApiEvaluto.Plug.LoadTenant
    plug ApiEvaluto.Plug.EnsureAdmin
  end

  scope "/api", ApiEvalutoWeb do
    pipe_through :api

    post "/register", RegistrationController, :create
    post "/authenticate", AuthenticationController, :create        
    
  end

  scope "/api/admin", ApiEvalutoWeb.Admin do
    pipe_through [:api, :jwt_authenticated_admin]

    resources "/tenants", TenantController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/groups", GroupController, except: [:new, :edit]
    resources "/credentials", CredentialController, except: [:new, :edit]
    resources "/memberships", MembershipController, except: [:new, :edit]
    resources "/user_types", UserTypeController, except: [:new, :edit]
    resources "/access_keys", AccessKeyController, except: [:new, :edit]

   
  end
end