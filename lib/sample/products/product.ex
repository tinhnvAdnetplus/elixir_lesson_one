defmodule Sample.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price, :integer
    field :stock, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :stock])
    |> validate_required([:name, :price, :stock])
  end
end
