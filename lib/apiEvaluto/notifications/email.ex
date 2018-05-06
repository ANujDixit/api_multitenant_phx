defmodule ApiEvaluto.Notifications.Email do    
    use Bamboo.Phoenix, view: ApiEvalutoWeb.EmailView
    
    @from "noreply@evaluto.com"
  
    def admin_account_verification(first_name, email, tenant_name, tenant_code, verification_url) do
      base_email(email)
      |> to(email)
      |> subject("Verify your email for account-#{tenant_name} (Company code:#{tenant_code})")
      |> assign(:first_name, first_name)
      |> assign(:tenant_name, tenant_name)
      |> assign(:tenant_code, tenant_code)
      |> assign(:verification_url, verification_url)
      |> render("admin_account_verification.html")
    end  
  
    defp base_email(email) do
      new_email()
      |> from(@from)
      |> to(email)
      |> put_html_layout({ApiEvalutoWeb.LayoutView, "email.html"})
    end
    

    
end