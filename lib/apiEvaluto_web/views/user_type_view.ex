defmodule ApiEvalutoWeb.UserTypeView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.UserTypeView

  def render("index.json", %{user_types: user_types}) do
    %{data: render_many(user_types, UserTypeView, "user_type.json")}
  end

  def render("show.json", %{user_type: user_type}) do
    %{data: render_one(user_type, UserTypeView, "user_type.json")}
  end

  def render("user_type.json", %{user_type: user_type}) do
    %{id: user_type.id,
      name: user_type.name,
      actions: user_type.actions}
  end
end
