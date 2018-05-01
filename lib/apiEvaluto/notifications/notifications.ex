defmodule ApiEvaluto.Notifications do
    alias ApiEvaluto.Notifications.{Mailer, Email}

    def send_account_creation_invitation_email(user, verification_url) do 
        Email.user_invitation_email(user, verification_url) |> Mailer.deliver_later()
    end    
end