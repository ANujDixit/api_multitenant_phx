defmodule ApiEvalutoWeb.ActionGroupView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.ActionGroupView

  def render("index.json", %{action_groups: action_groups}) do
    %{data: render_many(action_groups, ActionGroupView, "action_group.json")}
  end

  def render("show.json", %{action_group: action_group}) do
    %{data: render_one(action_group, ActionGroupView, "action_group.json")}
  end

  def render("action_group.json", %{action_group: action_group}) do
    %{id: action_group.id,
      name: action_group.name,
      active: action_group.active}
  end
end
