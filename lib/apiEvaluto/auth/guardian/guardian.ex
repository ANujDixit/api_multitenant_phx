defmodule ApiEvaluto.Guardian do
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

      tenant_code = claims["tenant_code"]
      user_id = claims["sub"] 
      
      resource =  
        case Accounts.load_user_tenant_role(user_id) do
          %{user: u, tenant: t, role: r, tenant_code: code} when not is_nil(u) and 
                                                                 not is_nil(t) and 
                                                                 not is_nil(r) and 
                                                                 code == tenant_code
              ->  %{user: u, tenant: t, role: r, tenant_code: code}
            _
              ->  nil        
        end
      {:ok,  resource}
    end
  
    def resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end