defmodule Oprah.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Oprah.Web, :controller
      use Oprah.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      alias Oprah.{Repo,User}
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Oprah.Repo
      alias Oprah.User
      import Ecto
      import Ecto.Query

      import Oprah.Router.Helpers
      import Oprah.Gettext
      import Oprah.Auth, only: [require_current_user: 2]
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Oprah.Router.Helpers
      import Oprah.ErrorHelpers
      import Oprah.Gettext

      def avatar(user, size \\ 20) do
        tag :img, src: user.avatar_url, width: size
      end

      def markdown_render(str) do
        {:safe, escaped} = html_escape(str)
        rendered = Earmark.as_html!(escaped, %Earmark.Options{gfm: true})
        {:safe, rendered}
      end

      def nomination_link(conn, user, text) do
        link text, to: nomination_path(conn, :new, %{nomination: %{nominee_id: user.id}})
      end
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Oprah.Repo
      import Ecto
      import Ecto.Query
      import Oprah.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
