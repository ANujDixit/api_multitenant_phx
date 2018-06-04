defmodule ApiEvaluto.SuperAdmin.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :apiEvaluto,
                                module: ApiEvaluto.SuperAdmin.Guardian,
                                error_handler: ApiEvaluto.Guardian.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end