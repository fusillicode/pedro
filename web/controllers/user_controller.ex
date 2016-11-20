defmodule Pedro.UserController do
  @moduledoc """
  """
  use Pedro.Web, :controller
  alias Pedro.User

  def new(conn, _params) do
    render conn, changeset: User.registration_changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    result =
      %User{}
      |> User.registration_changeset(user_params)
      |> Repo.insert()

    case result do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Successful registraion")
        |> redirect(to: session_path(conn, :new))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
