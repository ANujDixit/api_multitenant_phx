defmodule ApiEvaluto.Accounts do
  use ApiEvaluto.Accounts.Access.Tenant
  use ApiEvaluto.Accounts.Access.Group
  use ApiEvaluto.Accounts.Access.User
  use ApiEvaluto.Accounts.Access.Credential
  use ApiEvaluto.Accounts.Access.Membership
  use ApiEvaluto.Accounts.Access.Registration
  use ApiEvaluto.Accounts.Access.Auth
  use ApiEvaluto.Accounts.Access.UserType
  use ApiEvaluto.Accounts.Access.AccessKey  
end
