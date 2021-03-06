defmodule ApiEvalutoWeb.CredentialView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.CredentialView

  def render("index.json", %{credentials: credentials}) do
    %{data: render_many(credentials, CredentialView, "credential.json")}
  end

  def render("show.json", %{credential: credential}) do
    %{data: render_one(credential, CredentialView, "credential.json")}
  end

  def render("credential.json", %{credential: credential}) do
    %{id: credential.id,
      email: credential.email,
      password_hash: credential.password_hash}
  end
end
