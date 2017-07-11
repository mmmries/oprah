defmodule Oprah.State do
  defstruct nominations: [],
            users: [],
            awards: []

  def apply_event(%{type: :new_user, data: user}, state) do
    Map.put(state, :users, [user | state.users])
  end

  def get_user(state, id) do
    case Enum.find(state.users, &( &1.id == id )) do
      nil -> {:error, :not_found}
      user -> {:ok, state, [], user}
    end
  end

  def user_all(state), do: {:ok, state, [], state.users}

  def user_upsert_by_gitlab_id(state, %Oprah.User{gitlab_id: gitlab_id}=user) do
    case Enum.find(state.users, &( &1.gitlab_id == gitlab_id )) do
      nil ->
        new_user_event = %{
          type: :new_user,
          occured_at: DateTime.utc_now,
          data: user,
        }
        new_state = apply_event(new_user_event, state)
        {:ok, new_state, [new_user_event], user}
      existing_user ->
        {:ok, state, [], existing_user}
    end
  end
end
