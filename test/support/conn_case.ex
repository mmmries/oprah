defmodule Oprah.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  import Oprah.TestHelpers
  import Plug.Conn
  alias Oprah.Image

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      import Oprah.Router.Helpers
      alias Oprah.Image

      # The default endpoint for testing
      @endpoint Oprah.Endpoint
    end
  end

  setup tags do
    conn = Phoenix.ConnTest.build_conn()
    if tags[:login_as] do
      {:ok, user} = Image.get_user(tags[:login_as])
      {:ok, conn: assign(conn, :current_user, user), user: user}
    else
      {:ok, conn: conn}
    end
  end
end
