defmodule ApiEvaluto.Auth.Token do
  alias ApiEvaluto.Accounts.User
   
  @account_verification_salt "evaluto is created by audix technologies"

  def generate_new_account_token(%User{id: user_id, tenant_id: tenant_id}) do
    Phoenix.Token.sign(ApiEvalutoWeb.Endpoint, @account_verification_salt, Enum.join([tenant_id, user_id], "_") )
  end
  
  def verify_new_account_token(token) do
    max_age = 86_4000 # tokens that are older than a day should be invalid
    Phoenix.Token.verify(ApiEvalutoWeb.Endpoint, @account_verification_salt, token, max_age: max_age)
  end
  
end