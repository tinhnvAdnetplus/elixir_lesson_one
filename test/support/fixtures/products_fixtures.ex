defmodule Sample.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sample.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: 42,
        stock: 42
      })
      |> Sample.Products.create_product()

    product
  end
end
