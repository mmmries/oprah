defmodule Oprah.EventFileSerializer do
  def serialize(event) do
    occured_at = DateTime.to_iso8601(event.occured_at)
    event = Map.put(event, :occured_at, occured_at)
    Poison.encode!(event)
  end
end
