defmodule ApiEvaluto.Plug.LoadTenant do
    import Plug.Conn
    alias ApiEvaluto.Accounts
    alias ApiEvaluto.Accounts.Tenant
  
    def init(options), do: options
  
    def call(conn, _opts) do
      user = ApiEvaluto.Guardian.Plug.current_resource(conn)    
      if user do
        tenant = user.tenant
      else
        tenant = nil  
      end            
      assign(conn, :tenant, tenant)
    end
end