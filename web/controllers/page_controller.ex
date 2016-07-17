defmodule Oprah.PageController do
  use Oprah.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
