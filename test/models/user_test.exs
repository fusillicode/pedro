defmodule Pedro.UserTest do
  use Pedro.ModelCase

  alias Pedro.User

  @valid_attrs %{email: "johndoe@test.com", password: "securepass", password_confirmation: "securepass"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.registration_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
