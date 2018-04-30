defmodule ApiEvalutoWeb.AccessKeyView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.AccessKeyView

  def render("index.json", %{access_keys: access_keys}) do
    %{data: render_many(access_keys, AccessKeyView, "access_key.json")}
  end

  def render("show.json", %{access_key: access_key}) do
    %{data: render_one(access_key, AccessKeyView, "access_key.json")}
  end

  def render("access_key.json", %{access_key: access_key}) do
    %{id: access_key.id,
      name: access_key.name}
  end
end
