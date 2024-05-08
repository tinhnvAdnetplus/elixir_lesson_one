defmodule Sample.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sample.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        address: "some address",
        birthday: ~D[2024-05-07],
        contract_type: 42,
        department: "some department",
        email: "some email",
        name: "some name",
        phone: "some phone",
        start_date: ~D[2024-05-07]
      })
      |> Sample.Users.create_user()

    user
  end
end
