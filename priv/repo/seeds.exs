# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Oprah.Repo.insert!(%Oprah.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Oprah.Repo.insert!(%Oprah.User{name: "Ron Swanson"})
Oprah.Repo.insert!(%Oprah.User{name: "Leslie Knope"})
Oprah.Repo.insert!(%Oprah.User{name: "Burt Macklin"})
Oprah.Repo.insert!(%Oprah.User{name: "Tom Haverford"})
