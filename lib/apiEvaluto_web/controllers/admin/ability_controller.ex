defmodule ApiEvalutoWeb.AbilityController do
  use ApiEvalutoWeb, :controller

  alias ApiEvaluto.Authorization
  alias ApiEvaluto.Authorization.Ability

  action_fallback ApiEvalutoWeb.FallbackController

  def index(conn, _params) do
    abilities = Authorization.list_abilities()
    render(conn, "index.json", abilities: abilities)
  end

  def create(conn, %{"ability" => ability_params}) do
    with {:ok, %Ability{} = ability} <- Authorization.create_ability(ability_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ability_path(conn, :show, ability))
      |> render("show.json", ability: ability)
    end
  end

  def show(conn, %{"id" => id}) do
    ability = Authorization.get_ability!(id)
    render(conn, "show.json", ability: ability)
  end

  def update(conn, %{"id" => id, "ability" => ability_params}) do
    ability = Authorization.get_ability!(id)

    with {:ok, %Ability{} = ability} <- Authorization.update_ability(ability, ability_params) do
      render(conn, "show.json", ability: ability)
    end
  end

  def delete(conn, %{"id" => id}) do
    ability = Authorization.get_ability!(id)
    with {:ok, %Ability{}} <- Authorization.delete_ability(ability) do
      send_resp(conn, :no_content, "")
    end
  end
end
