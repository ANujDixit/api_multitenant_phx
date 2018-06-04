defmodule ApiEvalutoWeb.Router do
  use ApiEvalutoWeb, :router
  alias ApiEvaluto.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  pipeline :jwt_authenticated_admin do
    plug Guardian.AuthPipeline   
    plug ApiEvaluto.Plug.EnsureAdmin
  end

  scope "/api", ApiEvalutoWeb do
    pipe_through :api
    
    post "/signup", RegistrationController, :create
    get "/verify-tenants", RegistrationController, :verify_tenant
    post "/signin", AuthenticationController, :create   
    resources "/tenants", TenantController, only: [:index]
    
  end
  
  scope "/api/superadmin", ApiEvalutoWeb.SuperAdmin do
    pipe_through :api
    
    post "/signin", AuthenticationController, :create   
  end
  
  scope "/api/superadmin", ApiEvalutoWeb do
    pipe_through [:api, :jwt_authenticated_admin]
    
    resources "/tenants", TenantController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    
    resources "/credentials", CredentialController, except: [:new, :edit]
    resources "/memberships", MembershipController, except: [:new, :edit]
    
  end

  scope "/api/admin", ApiEvalutoWeb.Admin do
    pipe_through [:api, :jwt_authenticated_admin]
    
    resources "/questions", QuestionController, except: [:new, :edit]
    resources "/groups", GroupController, except: [:new, :edit]
    
    resources "/roles", RoleController, except: [:new, :edit]
    resources "/access_keys", AccessKeyController, except: [:new, :edit]
    resources "/action_groups", ActionGroupController, except: [:new, :edit]
    resources "/actions", ActionController, except: [:new, :edit]
    resources "/abilities", AbilityController, except: [:new, :edit]
    resources "/tests", TestController, except: [:new, :edit]

 
  end
end