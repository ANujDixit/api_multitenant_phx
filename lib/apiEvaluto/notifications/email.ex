defmodule ApiEvaluto.Notifications.Email do    
    import Bamboo.Phoenix, view: ApiEvalutoWeb.EmailView

    def user_invitation_email(user, verification_url) do
        new_email
        |> to("foo@example.com")
        |> from("me@example.com")
        |> subject("Welcome!!!")
        |> html_body("<strong>Welcome</strong>")
        |> text_body("welcome")
        html: Phoenix.View.render_to_string(MyApp.EmailView, "welcome.html", some_var: some_var),
    end   
    

    
end