defmodule ApiEvaluto.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :apiEvaluto,
                                module: ApiEvaluto.Guardian,
                                error_handler: ApiEvaluto.Guardian.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated    
    plug Guardian.Plug.LoadResource
    plug ApiEvaluto.Plug.LoadTenant
    plug ApiEvaluto.Plug.EnsureAdmin
end