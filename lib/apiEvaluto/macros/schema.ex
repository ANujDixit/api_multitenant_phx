defmodule ApiEvaluto.Schema do
    defmacro __using__(_) do
      quote do
        use Ecto.Schema
        import Ecto.Changeset
        alias ApiEvaluto.Accounts.Tenant
        @primary_key {:id, :binary_id, autogenerate: true}
        @foreign_key_type :binary_id
      end
    end
end