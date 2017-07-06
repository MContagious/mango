defmodule Mango.Catalog do
  alias Mango.Catalog.Product
  alias Mango.Repo
  def list_products() do
      Product
       |> Repo.all
  end

  def list_seasonal_products() do
      list_products()
      |> Enum.filter(fn(prod) -> prod.is_seasonal end)
  end

  def list_products_by_category(category) do
    list_products()
      |> Enum.filter(fn(prod) -> prod.category == category end)
  end

end
