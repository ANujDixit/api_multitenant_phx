defmodule ApiEvalutoWeb.ActionView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.ActionView

  def render("index.json", %{actions: actions}) do
    %{data: render_many(actions, ActionView, "action.json")}
  end

  def render("show.json", %{action: action}) do
    %{data: render_one(action, ActionView, "action.json")}
  end

  def render("action.json", %{action: action}) do
    %{id: action.id,
      name: action.name,
      endpoint: action.endpoint,
      params: action.params,
      active: action.active}
  end
end
