require IEx

defmodule ForusWeb.Auth do

  alias Plug.Conn
  alias Forus.Accounts
  
  def login(conn, userId) do
    conn
    |> Conn.put_session(:user_id, userId)
    |> Conn.configure_session(renew: true)
  end

  def logout(conn) do
    Conn.configure_session(conn, drop: true)
  end

  def assign_current_user(conn, _) do
    case Conn.get_session(conn, :user_id) do
      nil -> conn
      user_id -> Conn.assign(conn, :user, Accounts.get_user!(user_id))
    end
  end

end
