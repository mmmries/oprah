defmodule Oprah.Nomination do
  defstruct body: nil, # a string in markdown format
            body_html: nil, # a string in html format
            nominated_by: nil, # an Oprah.User
            nominee: nil # an Oprah.User
end
