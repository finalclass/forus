defmodule ForusWeb.Accounts.SessionController do
  use ForusWeb, :controller

  alias Forus.Accounts
  alias Forus.Accounts.User
  alias ForusWeb.Auth

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_by_email_password email, password do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> Auth.login(user.id)
        |> redirect(to: "/")
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Bad email/password combination")
        |> redirect(to: accounts_session_path(conn, :new))
    end
    conn
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> redirect to: accounts_session_path(conn, :new)
  end
end
