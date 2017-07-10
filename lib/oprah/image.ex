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
    state = case Mix.env do
      :dev ->
        user = %Oprah.User{id: "b7AyXJu-PwlXTNdcfIPYjw==", name: "mmmries", gitlab_id: 69}
        {:ok, state, _, _} = State.user_upsert_by_gitlab_id(%State{}, user)
        state
      _ -> %State{}
    end
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
end
