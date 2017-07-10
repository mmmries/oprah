defmodule Oprah.NotFound do
  defexception [:message]
end

defimpl Plug.Exception, for: Oprah.NotFound do
  def status(_), do: 404
end
