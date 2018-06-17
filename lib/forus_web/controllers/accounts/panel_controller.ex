defmodule ForusWeb.Accounts.PanelController do
  use ForusWeb, :controller

  alias Forus.Accounts
  alias Forus.Accounts.Credential

  def index(conn, _params) do
    render(conn, "layout.html", panel_template: "index.html")
  end

  def change_password_form(conn, _params) do
    changeset = Accounts.change_credential(%Credential{})

    render(
      conn,
      "layout.html",
      panel_template: "change_password_form.html",
      changeset: changeset
    )
  end

  def change_password(conn, _params) do
    conn
    |> put_flash(:info, "Password changed.")
    |> redirect(to: accounts_panel_path(conn, :index))
  end
end
