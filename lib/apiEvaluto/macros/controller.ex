defmodule ApiEvaluto.Controller do
    defmacro __using__(_) do
      quote do
        use ApiEvalutoWeb, :controller
        action_fallback ApiEvalutoWeb.FallbackController
        
        def action(conn, _params) do
          apply(__MODULE__, action_name(conn), [conn, conn.params, ApiEvaluto.Guardian.Plug.current_resource(conn)])
        end
      end
    end
end