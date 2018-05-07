defmodule ApiEvalutoWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ApiEvalutoWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ApiEvalutoWeb.ChangesetView, "error.json", changeset: changeset)
  end
  
  def call(conn, {:error, :guardian_token_issue}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{error: "Guardian token generation issue"})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ApiEvalutoWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Login error"})
  end

  def call(conn, {:error, :tenant_not_found}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: "Tenant Not found"})
  end

  def call(conn, {:error, {:unauthorized, msg}}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: msg})
  end
  
  def call(conn, {:error, {_, msg}}) do
    conn
    |> put_status(:not_found)
    |> json(%{error: msg})
  end
  
end
