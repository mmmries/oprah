defmodule Oprah.Image do
  use GenServer
  alias Oprah.State

  # Client API

  def get_user(id), do: GenServer.call(__MODULE__, {:get_user, id})

  def user_all, do: GenServer.call(__MODULE__, :user_all)

  def user_upsert_by_gitlab_id(user), do: GenServer.call(__MODULE__, {:user_upsert_by_gitlab_id, user})

  # GenServer Details
  def start_link, do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def init(nil) do
    state = load_state_from_event_file()
    {:ok, state}
  end

  def handle_call({command, arg}, _from, state) do
    case apply(State, command, [state, arg]) do
      {:ok, state, _events, user} -> {:reply, {:ok, user}, state}
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end
  def handle_call(command, _from, state) do
    {:ok, state, _events, result} = apply(State, command, [state])
    {:reply, {:ok, result}, state}
  end

  defp load_state_from_event_file do
    Application.get_env(:oprah, :event_file)
    |> Oprah.EventFileParser.stream_from_file
    |> Enum.reduce(%State{}, &State.apply_event/2)
  end
end
