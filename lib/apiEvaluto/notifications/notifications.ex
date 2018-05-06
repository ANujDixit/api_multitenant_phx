defmodule ApiEvaluto.Notifications do
    alias ApiEvaluto.Notifications.{Mailer, Email}

    def send_admin_account_verification_email( first_name, email, tenant_name, tenant_code, verification_url) do 
        Email.admin_account_verification(first_name, email, tenant_name, tenant_code, verification_url) 
        |> Mailer.deliver_later()
    end    
end