defmodule ForusWeb.HomeController do
  use ForusWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
