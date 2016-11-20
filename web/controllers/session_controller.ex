defmodule Pedro.SessionController do
  @moduledoc """
  """
  use Pedro.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Pedro.User
  alias Guardian.Plug

  def new(conn, _params) do
    render conn
  end

  def create(conn, %{"session" => %{"email" => "", "password" => ""}}) do
    conn
    |> put_flash(:error, "Please fill in an email address and password")
    |> render("new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case verify_credentials(email, password) do
      {:ok, user} ->
        conn
        |> Plug.sign_in(user)
        |> put_flash(:info, "Successfully signed in")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:info, "Invalid email address or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Plug.sign_out()
    |> put_flash(:info, "Successfully signed out")
    |> redirect(to: session_path(conn, :new))
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: session_path(conn, :new))
  end

  defp verify_credentials(email, password) do
    with {:ok, user} <- find_by_email(email),
      do: verify_password(password, user)
  end

  defp find_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "User with email '#{email}' not found"}
      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{password_hash: password_hash} = user) do
    if checkpw(password, password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
