defmodule ApiEvaluto.Guardian do
    use Guardian, otp_app: :apiEvaluto
    alias ApiEvaluto.Accounts
    alias ApiEvaluto.Accounts.Tenant
  
    def subject_for_token(user, _claims) do
      sub = to_string(user.id)
      {:ok, sub}
    end
  
    def subject_for_token(_, _) do
      {:error, :reason_for_error}
    end
  
    def resource_from_claims(claims) do

      tenant_code = claims["tenant_code"]
      user_id = claims["sub"] 
      
      resource =  
        case Accounts.load_user_tenant_user_type(user_id) do
          user when not is_nil(user) -> user
           _ -> nil        
        end
                  
      if resource && resource.tenant && resource.tenant.code != tenant_code do
        resource = nil
      end      
      
      {:ok,  resource}
    end
  
    def resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end