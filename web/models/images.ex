defmodule Oprah.Images do
  import Oprah.Router.Helpers

  def error_url(conn) do
    random_image_path(conn, "errors")
  end

  def success_url(conn) do
    random_image_path(conn, "success")
  end

  defp random_image_path(conn, group) do
    :rand.seed(:exsplus, :erlang.now)
    relative_dir = "priv/static/images/#{group}"
    filepath = Path.join([__DIR__, "../../", relative_dir])
    basenames = File.ls!(filepath) |> Enum.filter(&( !String.starts_with?(&1, ".") ))
    basename = Enum.shuffle(basenames) |> List.first
    static_path(conn, "/images/#{group}/#{basename}")
  end
end
