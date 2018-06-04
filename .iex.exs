import Ecto
import Ecto.Query, warn: false

alias ApiEvaluto.Repo
alias ApiEvaluto.Accounts
alias ApiEvaluto.Accounts.{Tenant, User, Credential, Membership, UserType, AccessKey, Group, AdminUser}
alias ApiEvaluto.Library
alias ApiEvaluto.Library.{ Question, Choice}
alias ApiEvaluto.Notifications
alias ApiEvaluto.Notifications.{ Mailer, Email}