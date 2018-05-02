defmodule ApiEvalutoWeb.AbilityView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.AbilityView

  def render("index.json", %{abilities: abilities}) do
    %{data: render_many(abilities, AbilityView, "ability.json")}
  end

  def render("show.json", %{ability: ability}) do
    %{data: render_one(ability, AbilityView, "ability.json")}
  end

  def render("ability.json", %{ability: ability}) do
    %{id: ability.id,
      create: ability.create,
      read: ability.read,
      update: ability.update,
      delete: ability.delete}
  end
end
