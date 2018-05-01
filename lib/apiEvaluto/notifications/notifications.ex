defmodule ApiEvaluto.Notifications do
    alias ApiEvaluto.Notifications.{Mailer, Email}

    def send_admin_account_verification_email(name, email, tenant_name, verification_url) do 
        Email.admin_account_verification(name, email, tenant_name, verification_url) |> Mailer.deliver_later()
    end    
end