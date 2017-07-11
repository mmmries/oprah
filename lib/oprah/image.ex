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
    event_filepath = Application.get_env(:oprah, :event_file)
    state = load_state_from_event_file(event_filepath)
    event_filehandle = File.open!(event_filepath, [:append, :binary])
    {:ok, %{state: state, event_filehandle: event_filehandle}}
  end

  if Mix.env == :test do
    def handle_call({:set_state_to, state}, _from, s) do
      {:reply, :ok, Map.put(s, :state, state)}
    end
  end
  def handle_call({command, arg}, _from, s) do
    handle_state_result(s, apply(State, command, [s.state, arg]))
  end
  def handle_call(command, _from, s) do
    handle_state_result(s, apply(State, command, [s.state]))
  end

  def handle_state_result(s, {:ok, state, events, reply_data}) do
    s = Map.put(s, :state, state)
    Enum.each(events, fn(event) ->
      serialized_event = Oprah.EventFileSerializer.serialize(event)
      :ok = IO.write(s.event_filehandle, [serialized_event, "\n"])
    end)
    {:reply, {:ok, reply_data}, s}
  end
  def handle_state_result(s, {:error, reason}) do
    {:reply, {:error, reason}, s}
  end

  defp load_state_from_event_file(filepath) do
    if File.exists?(filepath) do
      filepath
      |> Oprah.EventFileParser.stream_from_file
      |> Enum.reduce(%State{}, &State.apply_event/2)
    end
  end
end
