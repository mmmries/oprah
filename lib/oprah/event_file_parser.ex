defmodule Oprah.EventFileParser do
  def stream_from_file(filepath) do
    filepath
    |> File.stream!
    |> Stream.map(&Poison.decode!/1)
    |> Stream.map(&json_map_to_event/1)
  end

  defp atomize_keys(map) do
    Enum.reduce(map, %{}, fn({key, val}, newmap) ->
      Map.put(newmap, String.to_atom(key), val)
    end)
  end

  defp json_map_to_event(map) do
    {:ok, occured_at, 0} = map |> Map.fetch!("occured_at") |> DateTime.from_iso8601
    type = Map.fetch!(map, "type") |> String.to_atom
    %{
      type: type,
      occured_at: occured_at,
      data: Map.merge(type_to_struct(type), map |> Map.get("data") |> atomize_keys),
    }
  end

  defp type_to_struct(:new_user), do: %Oprah.User{}
end
