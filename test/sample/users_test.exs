defmodule Sample.UsersTest do
  use Sample.DataCase

  alias Sample.Users

  describe "users" do
    alias Sample.Users.User

    import Sample.UsersFixtures

    @invalid_attrs %{name: nil, address: nil, phone: nil, email: nil, birthday: nil, department: nil, contract_type: nil, start_date: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", address: "some address", phone: "some phone", email: "some email", birthday: ~D[2024-05-07], department: "some department", contract_type: 42, start_date: ~D[2024-05-07]}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.address == "some address"
      assert user.phone == "some phone"
      assert user.email == "some email"
      assert user.birthday == ~D[2024-05-07]
      assert user.department == "some department"
      assert user.contract_type == 42
      assert user.start_date == ~D[2024-05-07]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", phone: "some updated phone", email: "some updated email", birthday: ~D[2024-05-08], department: "some updated department", contract_type: 43, start_date: ~D[2024-05-08]}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.address == "some updated address"
      assert user.phone == "some updated phone"
      assert user.email == "some updated email"
      assert user.birthday == ~D[2024-05-08]
      assert user.department == "some updated department"
      assert user.contract_type == 43
      assert user.start_date == ~D[2024-05-08]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
