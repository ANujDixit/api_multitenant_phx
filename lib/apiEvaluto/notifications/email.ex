defmodule ApiEvaluto.Notifications.Email do    
    use Bamboo.Phoenix, view: ApiEvalutoWeb.EmailView
    
    @from "noreply@evaluto.com"
  
    def admin_account_verification(name, email, tenant_name, verification_url) do
      base_email(email)
      |> to(email)
      |> subject("Welcome!!!")
      |> assign(:name, name)
      |> assign(:tenant_name, tenant_name)
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