defmodule Sample.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Sample.Repo

  alias Sample.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users1(params) do
    department = Map.get(params, "department", "")
    contract_type = Map.get(params, "contract_type", "")

    query =
      from u in User,
        where: ilike(u.department, ^"%#{department}%") and u.contract_type == ^contract_type,
        order_by: [desc: u.start_date]

    Repo.all(query)
  end

  def list_users(params) do
    filter_params = params |> Map.filter(fn {_key, value} -> value !== "" and value !== "0" end)
    IO.inspect(filter_params)
    query = from(u in User)

    query =
      unless is_nil(filter_params["contract_type"]),
        do: query |> where([u], u.contract_type == ^filter_params["contract_type"]),
        else: query

    query =
      unless is_nil(filter_params["department"]),
        do: query |> where([u], ilike(u.department, ^"%#{filter_params["department"]}%")),
        else: query

    query =
      unless is_nil(filter_params["start_date"]),
        do: query |> where([u], u.start_date == ^filter_params["start_date"]),
        else: query

    query =
      unless is_nil(filter_params["year"]) do
        {start_year, _} = Integer.parse(filter_params["year"])

        query
        |> where(
          [u],
          fragment("EXTRACT(YEAR FROM ?) = ?", u.updated_at, ^start_year)
        )
      else
        query
      end

    query =
      unless is_nil(filter_params["month"]) do
        {start_month, _} = Integer.parse(filter_params["month"])

        query
        |> where(
          [u],
          fragment("EXTRACT(MONTH FROM ?) = ?", u.updated_at, ^start_month)
        )
      else
        query
      end

    query
    |> order_by([u], desc: u.start_date)
    |> select([u], u)
    |> Repo.all()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  ## Examples
    
      iex> get_contract_type_label(1)
      "正社員"

      iex> delete_user(0)
      {:error, "このタイプの契約は見つかりませんでした。"}
  """
  def get_contract_type_list(),
    do: ["", "正社員", "契約社員", "アルバイト"]

  @doc """
  ## Examples
    
      iex> get_contract_type_label(1)
      "正社員"

      iex> delete_user(0)
      {:error, "このタイプの契約は見つかりませんでした。"}
  """
  def get_contract_type_label(contract_type) when contract_type >= 1,
    do: Enum.at(get_contract_type_list(), contract_type)

  def get_contract_type_label(_), do: {:error, "このタイプの契約は見つかりませんでした。"}
end
