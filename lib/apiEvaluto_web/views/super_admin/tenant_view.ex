defmodule ApiEvalutoWeb.SuperAdmin.TenantView do
  use ApiEvalutoWeb, :view
  alias ApiEvalutoWeb.SuperAdmin.TenantView

  def render("index.json", %{tenants: tenants}) do
    %{data: render_many(tenants, TenantView, "tenant.json")}
  end

  def render("show.json", %{tenant: tenant}) do
    %{data: render_one(tenant, TenantView, "tenant.json")}
  end

  def render("tenant.json", %{tenant: tenant}) do
    %{id: tenant.id,
      name: tenant.name,
      slug: tenant.slug,
      code: tenant.code}
  end
end
