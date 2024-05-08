defmodule Sample.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :address, :string
    field :phone, :string
    field :email, :string
    field :birthday, :date
    field :department, :string
    field :contract_type, :integer
    field :start_date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :address,
      :phone,
      :email,
      :birthday,
      :department,
      :contract_type,
      :start_date
    ])
    |> validate_required([
      :name,
      :address,
      :phone,
      :email,
      :birthday,
      :department,
      :contract_type,
      :start_date
    ])
  end
end
