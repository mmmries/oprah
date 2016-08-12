defmodule Oprah.NominationView do
  use Oprah.Web, :view

  def reversed_keys(map) do
    Map.keys(map) |> Enum.sort_by(&( Ecto.DateTime.to_erl(&1) )) |> Enum.reverse
  end
end
