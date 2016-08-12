defmodule Oprah.NominationView do
  use Oprah.Web, :view

  def reversed_keys(map) do
    Map.keys(map) |> Enum.sort |> Enum.reverse
  end
end
