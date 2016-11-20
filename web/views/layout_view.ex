defmodule Pedro.LayoutView do
  use Pedro.Web, :view
  alias Guardian.Plug

  def current_user(conn), do: Plug.current_resource(conn)
  def logged_in?(conn), do: Plug.authenticated?(conn)
end
