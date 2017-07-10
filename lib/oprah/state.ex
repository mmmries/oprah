defmodule Oprah.State do
  defstruct nominations: [],
            users: [],
            awards: []

  def get_user(state, id) do
    case Enum.find(state.users, &( &1.id == id )) do
      nil -> {:error, :not_found}
      user -> {:ok, state, [], user}
    end
  end

  def user_upsert_by_gitlab_id(state, %Oprah.User{gitlab_id: gitlab_id}=user) do
    case Enum.find(state.users, &( &1.gitlab_id == gitlab_id )) do
      nil ->
        new_state = Map.put(state, :users, [user | state.users])
        new_user_event = %{
          type: :new_user,
          occured_at: DateTime.utc_now |> DateTime.to_iso8601,
          data: user,
        }
        {:ok, new_state, [new_user_event], user}
      existing_user ->
        {:ok, state, [], existing_user}
    end
  end
end
