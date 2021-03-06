defmodule ApiEvaluto.Plug.EnsureSuperAdmin do
    import Plug.Conn
    import Phoenix.Controller, only: [render: 4]
    alias ApiEvaluto.Accounts   
  
    def init(options), do: options
  
    def call(conn, _opts) do      
      resource = ApiEvaluto.Guardian.Plug.current_resource(conn)
      if resource do        
        conn        
      else      
        conn   
        |> put_status(:unauthorized)
        |> render(ApiEvalutoWeb.ErrorView, "401.json", message: "Unauthenticated super admin user")
        |> halt()
      end      
    end

end