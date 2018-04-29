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
      id = claims["sub"]
      code = claims["tenant_code"]
      
      resource =  with %Tenant{} = tenant <- Accounts.get_tenant_by_code(code) do 
                    Accounts.get_user!(tenant, id)
                  else
                    _ -> nil  
                  end        
      {:ok,  resource}
    end
  
    def resource_from_claims(_claims) do
      {:error, :reason_for_error}
    end
  end