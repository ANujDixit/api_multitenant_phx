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

      user_id = claims["sub"] 
      tenant_id = claims["tenant_id"]
     
      
      IO.inspect claims

      resource =  
        case Accounts.load_user_tenant_role(tenant_id, user_id) do
          %{user: u, tenant: t, role: r } when not is_nil(u) and not is_nil(t) and not is_nil(r) 
              ->  %{user: u, tenant: t, role: r}
            _
              ->  nil        
        end
      {:ok,  resource}
    end
  
    def resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end