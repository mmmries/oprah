defmodule Oprah.ModelCase do
  alias Oprah.State
  @moduledoc """
  This module defines the test case to be used by
  model tests.

  You may define functions here to be used as helpers in
  your model tests. See `errors_on/2`'s definition as reference.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  @fixture_state "test/support/fixture.jsonstream"
                 |> Oprah.EventFileParser.stream_from_file
                 |> Enum.reduce(%State{}, &State.apply_event/2)

  use ExUnit.CaseTemplate

  using do
    quote do
      import Oprah.ModelCase
    end
  end

  setup tags do
    :ok = GenServer.call(Oprah.Image, {:set_state_to, @fixture_state})
    :ok
  end
end
