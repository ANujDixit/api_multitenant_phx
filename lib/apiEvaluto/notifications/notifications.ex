defmodule ApiEvaluto.Notifications do
    alias ApiEvaluto.Notifications.{Mailer, Email}

    def send_admin_account_verification_email(email, verification_url) do 
        Email.admin_account_verification(email, verification_url) |> Mailer.deliver_later()
    end    
end