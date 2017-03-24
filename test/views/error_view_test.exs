defmodule Oprah.ErrorViewTest do
  use Oprah.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Oprah.ErrorView, "404.html", []) ==
           "<html><body><h1>Page not found</h1><br/><img src='/images/i_will_not_accept_that.gif' /></body></html>"
  end

  test "render 500.html" do
    assert render_to_string(Oprah.ErrorView, "500.html", []) ==
           "<html><body><h1>Internal server error</h1><br/><img src='/images/i_will_not_accept_that.gif' /></body></html>"
  end

  test "render any other" do
    assert render_to_string(Oprah.ErrorView, "505.html", []) ==
           "<html><body><h1>Internal server error</h1><br/><img src='/images/i_will_not_accept_that.gif' /></body></html>"
  end
end
