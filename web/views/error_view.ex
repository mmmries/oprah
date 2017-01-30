defmodule Oprah.ErrorView do
  use Oprah.Web, :view

  def render("404.html", _assigns) do
    {:safe, "<html><body><h1>Page not found</h1><br/><img src='/images/i_will_not_accept_that.gif' /></body></html>"}
  end

  def render("500.html", _assigns) do
    {:safe, "<html><body><h1>Internal server error</h1><br/><img src='/images/i_will_not_accept_that.gif' /></body></html>"}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
