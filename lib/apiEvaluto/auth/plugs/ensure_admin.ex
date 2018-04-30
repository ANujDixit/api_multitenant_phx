defmodule ApiEvaluto.Plug.EnsureAdmin do
    import Plug.Conn
    import Phoenix.Controller, only: [render: 4]
    alias ApiEvaluto.Accounts   
  
    def init(options), do: options
  
    def call(conn, _opts) do      
      if ApiEvaluto.Guardian.Plug.current_resource(conn).user_type.name == "Admin" do        
        conn        
      else      
        conn   
        |> put_status(:unauthorized)
        |> render(ApiEvalutoWeb.ErrorView, "401.json", message: "Unauthenticated admin user")
        |> halt()
      end      
    end

end