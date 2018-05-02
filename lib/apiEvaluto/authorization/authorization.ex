defmodule ApiEvaluto.Authorization do
  use ApiEvaluto.Authorization.Access.ActionGroup
  use ApiEvaluto.Authorization.Access.Action
  use ApiEvaluto.Authorization.Access.Ability
  use ApiEvaluto.Authorization.Access.Role
  use ApiEvaluto.Authorization.Access.AccessKey  
end
