defmodule ApiEvaluto.Plug.LoadTenant do
    import Plug.Conn
  
    def init(options), do: options
  
    def call(conn, _opts) do
      tenant = 
        case ApiEvaluto.Guardian.Plug.current_resource(conn)  do
        resource when not is_nil(resource) -> resource.tenant
        _ -> nil
        end
              
      assign(conn, :tenant, tenant)
    end
end