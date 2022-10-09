defmodule TodoistWeb.PageController do
  use TodoistWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
