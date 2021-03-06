defmodule ApiEvaluto.SuperAdmin.Guardian do
    use Guardian, otp_app: :apiEvaluto
    alias ApiEvaluto.Accounts   
  
    def subject_for_token(user, _claims) do
      sub = to_string(user.id)
      {:ok, sub}
    end
  
    def subject_for_token(_, _) do
      {:error, :reason_for_error}
    end
  
    def resource_from_claims(claims) do   
      user_id = claims["sub"] 
      resource = Accounts.get_admin_user!(user_id)
      {:ok,  resource}
    end
  
    def resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end