defmodule Oprah.Image do
  use GenServer
  alias Oprah.State
  @prefill_events [
  ]

  # Client API

  def get_user(id), do: GenServer.call(__MODULE__, {:get_user, id})

  def user_upsert_by_gitlab_id(user), do: GenServer.call(__MODULE__, {:user_upsert_by_gitlab_id, user})

  # GenServer Details
  def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def init(nil) do
    state = %State{}
    #state = Enum.reduce(@prefill_events, state, &apply_event_to_state/2)
    {:ok, state}
  end

  def handle_call({command, arg}, _from, state) do
    case apply(State, command, [state, arg]) do
      {:ok, state, _events, user} -> {:reply, {:ok, user}, state}
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end
end
