defmodule Oprah.EventFileParserTest do
  use ExUnit.Case, async: true
  alias Oprah.EventFileParser

  test "parsing the test fixtures" do
    new_users = "config/test.jsonstream" |> EventFileParser.stream_from_file |> Enum.to_list
    expected_event1 = %{
      type: :new_user,
      occured_at:  DateTime.from_iso8601("2017-07-10T21:01:00.000000Z") |> elem(1),
      data: %{
        name: "dan",
        id: "dan",
        gitlab_id: 1,
      }
    }
    assert expected_event1 = Enum.at(new_users, 0)
    assert new_users |> Enum.at(1) |> get_in([:data, :name]) == "don"
  end
end
