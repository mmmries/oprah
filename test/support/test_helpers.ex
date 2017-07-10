defmodule Oprah.TestHelpers do
  alias Oprah.User

  def insert_user(name) do
    %User{name: name} |> Repo.insert!
  end
end
